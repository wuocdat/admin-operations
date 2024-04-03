import 'package:equatable/equatable.dart';

class TaskType extends Equatable {
  const TaskType({
    required this.id,
    required this.name,
    required this.isActive,
  });

  final String id;
  final String name;
  final bool isActive;

  @override
  List<Object> get props => [id, name, isActive];
}
