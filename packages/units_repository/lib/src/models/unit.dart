import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit.g.dart';

@JsonSerializable()
class Unit extends Equatable {
  const Unit({
    required this.id,
    required this.name,
    required this.type,
    required this.createdBy,
    required this.createdAt,
    required this.isActive,
  });

  @JsonKey(name: "_id")
  final String id;
  final String name;
  final Map<String, dynamic> type;
  final String createdBy;
  final String createdAt;
  final bool isActive;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  static const Unit empty = Unit(
    id: '',
    name: '',
    type: {},
    createdBy: '',
    createdAt: '',
    isActive: false,
  );

  @override
  List<Object> get props => [id, name, type, createdAt, createdBy, isActive];
}
