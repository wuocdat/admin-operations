import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_repository/src/models/task_type.dart';
import 'package:units_repository/units_repository.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  const Task({
    required this.id,
    required this.isActive,
    required this.important,
    required this.content,
    required this.units,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.disable,
    required this.unitSent,
    required this.type,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool isActive;
  final bool important;
  final String content;
  final List<String> units;
  final String name;
  final String createdBy;
  final String createdAt;
  final bool disable;
  final Unit unitSent;
  final TaskType type;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  static const Task empty = Task(
    id: "",
    isActive: false,
    important: false,
    content: "",
    units: [],
    name: "",
    createdBy: "",
    createdAt: "",
    disable: true,
    unitSent: Unit.empty,
    type: TaskType.empty,
  );

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
