part of 'unit_manager_bloc.dart';

class UnitManagerState extends Equatable {
  const UnitManagerState({
    this.currentUnit = Unit.empty,
    this.childUnits = const [],
    this.childUnitTypes = const [],
    this.status = FetchDataStatus.initial,
    this.unitName = const Content.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.unitTypeId,
    this.isValid = false,
  });

  final Unit currentUnit;
  final List<Unit> childUnits;
  final FetchDataStatus status;
  final List<UnitType> childUnitTypes;

  //new unit form
  final Content unitName;
  final String? unitTypeId;
  final FormzSubmissionStatus formStatus;
  final bool isValid;

  UnitManagerState copyWith({
    Unit? currentUnit,
    List<Unit>? childUnits,
    FetchDataStatus? status,
    List<UnitType>? childUnitTypes,
    Content? unitName,
    String? unitTypeId,
    FormzSubmissionStatus? formStatus,
    bool? isValid,
  }) {
    return UnitManagerState(
      currentUnit: currentUnit ?? this.currentUnit,
      childUnits: childUnits ?? this.childUnits,
      childUnitTypes: childUnitTypes ?? this.childUnitTypes,
      status: status ?? this.status,
      unitName: unitName ?? this.unitName,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
    );
  }

  UnitManagerState copyWithAndClearForm() {
    return UnitManagerState(
      currentUnit: currentUnit,
      childUnits: childUnits,
      childUnitTypes: childUnitTypes,
      status: status,
      unitName: const Content.pure(),
      unitTypeId: null,
      formStatus: FormzSubmissionStatus.initial,
      isValid: false,
    );
  }

  @override
  List<Object?> get props => [
        currentUnit,
        childUnits,
        childUnitTypes,
        status,
        unitName,
        unitTypeId,
        formStatus,
        isValid,
      ];
}
