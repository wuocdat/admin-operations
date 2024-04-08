import 'package:api_client/src/task/models/task_type.dart';
import 'package:api_client/src/units/models/unit.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  const Task({
    required this.id,
    required this.important,
    required this.content,
    required this.units,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.disable,
    required this.unitSent,
    required this.isActive,
    required this.type,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool important;
  final String content;
  final List<String> units;
  final String name;
  final String createdBy;
  final String createdAt;
  final bool disable;
  final Unit unitSent;
  final bool isActive;
  final TaskType type;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @override
  List<Object> get props => [
        id,
        isActive,
        important,
        content,
        units,
        name,
        createdBy,
        createdAt,
        disable,
        unitSent,
        type
      ];
}
