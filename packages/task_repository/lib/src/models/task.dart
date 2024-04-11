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
  @JsonKey(fromJson: _fromJson)
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

  static List<String> _fromJson(List<dynamic> value) {
    if (value.isEmpty) return [];

    if (value.first is String) {
      return value.map((e) => e as String).toList();
    } else {
      return value.map((e) {
        final unitJson = e as Map<String, dynamic>;
        return Unit.fromJson(unitJson).id;
      }).toList();
    }
  }
}
