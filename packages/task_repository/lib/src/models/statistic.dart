import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statistic.g.dart';

@JsonSerializable()
class Statistic extends Equatable {
  const Statistic({
    required this.id,
    required this.name,
    required this.countMembers,
    required this.countReports,
    required this.totalMembers,
    required this.totalReports,
    this.children,
  });

  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int countMembers;
  final int countReports;
  final int totalMembers;
  final int totalReports;
  final List<Statistic>? children;

  factory Statistic.fromJson(Map<String, dynamic> json) =>
      _$StatisticFromJson(json);

  static const Statistic empty = Statistic(
    id: '',
    name: '',
    countMembers: 0,
    countReports: 0,
    totalMembers: 0,
    totalReports: 0,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        countMembers,
        countReports,
        totalMembers,
        totalReports,
        children,
      ];
}
