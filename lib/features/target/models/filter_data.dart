import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';

class FilterData extends Equatable {
  const FilterData({
    required this.startDate,
    required this.endDate,
    this.fbPageType,
  });

  final DateTime startDate;
  final DateTime endDate;
  final FbPageType? fbPageType;

  @override
  List<Object?> get props => [startDate, endDate, fbPageType];
}
