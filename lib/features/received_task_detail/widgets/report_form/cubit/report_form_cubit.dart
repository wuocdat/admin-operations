import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:formz/formz.dart';
import 'package:task_repository/task_repository.dart';
import '../models/report_times.dart';
import 'package:tctt_mobile/shared/models/content.dart';

part 'report_form_state.dart';

class ReportFormCubit extends Cubit<ReportFormState> {
  ReportFormCubit(
      {required TaskRepository taskRepository, required bool hideReportTimes})
      : _taskRepository = taskRepository,
        _hideReportTimes = hideReportTimes,
        super(const ReportFormState());

  final TaskRepository _taskRepository;
  final bool _hideReportTimes;

  void contentChanged(String stringValue) {
    final content = Content.dirty(stringValue);
    emit(state.copyWith(
      content: content,
      isValid: Formz.validate([content]) &&
          (_hideReportTimes || Formz.validate([state.times])),
    ));
  }

  void timesChanged(String times) {
    final reportTimes = ReportTimes.dirty(times);
    emit(state.copyWith(
      times: reportTimes,
      isValid: Formz.validate([state.content, reportTimes]),
    ));
  }

  void filesChanged(List<PlatformFile> files) {
    emit(state.copyWith(files: files));
  }

  Future<void> submit(String taskProgressId) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _taskRepository.reportTaskProgress(
          taskProgressId,
          state.content.value,
          !_hideReportTimes ? int.parse(state.times.value) : null,
          state.files.map((e) => e.path!).toList());
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
