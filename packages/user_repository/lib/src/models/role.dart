import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role extends Equatable {
  const Role({
    required this.id,
    required this.name,
    required this.managed,
  });

  @JsonKey(name: "_id")
  final String id;
  final String name;
  final List<String> managed;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  @override
  List<Object> get props => [id, name, managed];
}
