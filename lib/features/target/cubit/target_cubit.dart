import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/core/utils/constants.dart';
import 'package:tctt_mobile/core/utils/file.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/core/utils/time.dart';
import 'package:tctt_mobile/features/target/models/filter_data.dart';
import 'package:tctt_mobile/features/target/widgets/subject_actions/subject_actions.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:units_repository/units_repository.dart';

part 'target_state.dart';

class TargetCubit extends Cubit<TargetState> {
  TargetCubit({required TargetRepository targetRepository})
      : _targetRepository = targetRepository,
        super(const TargetState.subject());

  final TargetRepository _targetRepository;

  void changeOption(TargetOptions option) {
    emit(state.copyWith(selectedOption: option));
  }

  void changeViewIndex(int index) {
    emit(state.copyWith(viewIndex: index));
  }

  void resetTime() {
    emit(state.copyWith(
        startDate:
            DateTime.now().subtract(const Duration(days: defaultDayDuration)),
        endDate: DateTime.now()));
  }

  void updateFilterDataForActionView(FilterData data) {
    emit(state.copyWith(
      endDate: data.endDate,
      startDate: data.startDate,
      fbPageType: data.fbPageType,
      unsetFbType: data.fbPageType == null,
      targetName: data.targetName,
      currentUnit: data.currentUnit,
      stepUnitsList: data.stepUnitsList,
      subUnitsList: data.subUnitsList,
      updateFilterCount: state.updateFilterCount + 1,
    ));
  }

  Future<void> downloadExcelFile(String unitId) async {
    emit(state.copyWith(downloadingStatus: FetchDataStatus.loading));
    try {
      final path = await FileHelper.getFilePath(
          'report-${TimeUtils.getTimeStamp()}.xlsx');

      await _targetRepository.downloadExcelFile(
        state.selectedOption.typeAc,
        unitId,
        state.startDate!.stringFormat,
        state.endDate!.stringFormat,
        path,
      );

      emit(state.copyWith(downloadingStatus: FetchDataStatus.success));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(downloadingStatus: FetchDataStatus.failure));
    }
  }
}
