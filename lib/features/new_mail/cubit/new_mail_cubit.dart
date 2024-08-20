import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:formz/formz.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/features/new_task/bloc/new_task_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:units_repository/units_repository.dart';

part 'new_mail_state.dart';

class NewMailCubit extends Cubit<NewMailState> {
  NewMailCubit(
      {required MailRepository mailRepository,
      required UnitsRepository unitRepository})
      : _mailRepository = mailRepository,
        _unitsRepository = unitRepository,
        super(const NewMailState());

  final MailRepository _mailRepository;
  final UnitsRepository _unitsRepository;

  Future<void> fetchUnitTree() async {
    emit(state.copyWith(fetchDataStatus: FetchDataStatus.loading));

    try {
      final nodeList = await _unitsRepository.getFullUnitTree();

      emit(state.copyWith(
          unitNodes: nodeList, fetchDataStatus: FetchDataStatus.success));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(fetchDataStatus: FetchDataStatus.failure));
    }
  }

  void changeTitle(String titleStr) {
    final title = Content.dirty(titleStr);
    emit(state.copyWith(
      title: title,
      isValid: Formz.validate([title, state.content]) && state.units.isNotEmpty,
    ));
  }

  void changeContent(String contentStr) {
    final content = Content.dirty(contentStr);
    emit(state.copyWith(
      content: content,
      isValid: Formz.validate([content, state.title]) && state.units.isNotEmpty,
    ));
  }

  void changeUnits(String unitId, bool checked) {
    final cloneUnits = List.of(state.units);

    if (checked) {
      cloneUnits.add(unitId);
    } else {
      cloneUnits.remove(unitId);
    }

    emit(state.copyWith(
      units: cloneUnits,
      isValid:
          Formz.validate([state.content, state.title]) && cloneUnits.isNotEmpty,
    ));
  }

  void toggleImportant() {
    emit(state.copyWith(important: !state.important));
  }

  void pickFile(List<PlatformFile> files) {
    emit(state.copyWith(files: files));
  }

  Future<void> submitNewMail() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _mailRepository.sentMail(
            state.title.value,
            state.content.value,
            state.units,
            state.important,
            state.files.map((e) => e.path!).toList());
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        logger.severe(e);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  Future<List<TreeNodeData>> loadTreeNode(String parent) async {
    try {
      final units = await _unitsRepository.getUnitsByParentId(parent);

      return units.map((e) => e.toTreeNodeData()).toList();
    } catch (_) {
      return [];
    }
  }
}

extension UnitNodeX on UnitNode {
  TreeNodeData toTreeNodeData() {
    return TreeNodeData(
      extra: value,
      title: label,
      expaned: false,
      checked: false,
      children: [],
    );
  }
}
