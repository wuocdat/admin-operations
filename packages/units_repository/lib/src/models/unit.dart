import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit extends Equatable {
  const Unit({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
  });

  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String createdBy;
  final String createdAt;
  final bool isActive;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  @override
  List<Object> get props => [id, name, createdAt, createdBy, isActive];
}
