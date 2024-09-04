import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'target_overall.g.dart';

@JsonSerializable()
final class TargetOverall extends Equatable {
  const TargetOverall({
    required this.all,
    required this.reactionary,
    required this.subject_35,
  });

  final int all;
  final int reactionary;
  final int subject_35;

  static const empty = TargetOverall(all: 0, reactionary: 0, subject_35: 0);

  factory TargetOverall.fromJson(Map<String, dynamic> json) =>
      _$TargetOverallFromJson(json);

  @override
  List<Object> get props => [all, reactionary, subject_35];
}
