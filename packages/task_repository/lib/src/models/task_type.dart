import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_type.g.dart';

@JsonSerializable()
class TaskType extends Equatable {
  const TaskType({
    required this.id,
    required this.name,
    required this.isActive,
  });

  @JsonKey(name: "_id")
  final String id;
  final String name;
  final bool isActive;

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);

  @override
  List<Object> get props => [id, name, isActive];
}
