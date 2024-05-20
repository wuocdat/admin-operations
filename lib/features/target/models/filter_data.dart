import 'package:equatable/equatable.dart';

class FilterData extends Equatable {
  const FilterData({required this.startDate, required this.endDate});

  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}
