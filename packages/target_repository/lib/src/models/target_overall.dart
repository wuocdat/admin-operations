import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'target_overall.g.dart';

@JsonSerializable()
final class TargetOverall extends Equatable {
  const TargetOverall({required this.all});

  final int all;

  static const empty = TargetOverall(all: 0);

  factory TargetOverall.fromJson(Map<String, dynamic> json) =>
      _$TargetOverallFromJson(json);

  @override
  List<Object> get props => [all];
}
