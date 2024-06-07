part of 'filter_content_cubit.dart';

class FilterContentState extends Equatable {
  const FilterContentState({
    this.pickedStartDate,
    this.pickedEndDate,
    this.fbPageType,
    this.currentUnit = Unit.empty,
    this.stepUnitsList = const [],
    this.subUnitsList = const [],
    this.status = FetchDataStatus.initial,
  });

  final DateTime? pickedStartDate;
  final DateTime? pickedEndDate;
  final FbPageType? fbPageType;
  final Unit currentUnit;
  final List<Unit> stepUnitsList;
  final List<Unit> subUnitsList;
  final FetchDataStatus status;

  FilterContentState copyWith({
    DateTime? pickedStartDate,
    DateTime? pickedEndDate,
    FbPageType? fbPageType,
    Unit? currentUnit,
    List<Unit>? stepUnitsList,
    List<Unit>? subUnitsList,
    FetchDataStatus? status,
  }) {
    return FilterContentState(
      pickedStartDate: pickedStartDate ?? this.pickedStartDate,
      pickedEndDate: pickedEndDate ?? this.pickedEndDate,
      fbPageType: fbPageType ?? this.fbPageType,
      currentUnit: currentUnit ?? this.currentUnit,
      stepUnitsList: stepUnitsList ?? this.stepUnitsList,
      subUnitsList: subUnitsList ?? this.subUnitsList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        pickedEndDate,
        pickedStartDate,
        fbPageType,
        currentUnit,
        stepUnitsList,
        subUnitsList,
        status,
      ];
}
