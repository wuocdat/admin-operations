import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  const Unit({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
  });

  final String id;
  final String name;
  final String createdBy;
  final String createdAt;
  final bool isActive;

  @override
  List<Object> get props => [id, name, createdAt, createdBy, isActive];
}
