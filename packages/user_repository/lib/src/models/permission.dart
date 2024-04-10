import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission.g.dart';

@JsonSerializable()
class Permission extends Equatable {
  const Permission({
    required this.create,
    required this.update,
    required this.delete,
    required this.read,
  });

  final bool create;
  final bool update;
  final bool delete;
  final bool read;

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);

  @override
  List<Object> get props => [create, update, delete, read];
}
