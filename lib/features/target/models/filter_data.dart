import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:units_repository/units_repository.dart';

class FilterData extends Equatable {
  const FilterData({
    required this.startDate,
    required this.endDate,
    this.fbPageType,
    required this.targetName,
    required this.currentUnit,
    required this.stepUnitsList,
    required this.subUnitsList,
  });

  final DateTime startDate;
  final DateTime endDate;
  final FbPageType? fbPageType;
  final String targetName;
  final Unit currentUnit;
  final List<Unit> stepUnitsList;
  final List<Unit> subUnitsList;

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        fbPageType,
        targetName,
        currentUnit,
        stepUnitsList,
        subUnitsList,
      ];
}
