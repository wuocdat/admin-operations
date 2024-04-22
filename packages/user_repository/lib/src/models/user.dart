import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:units_repository/units_repository.dart';
import 'package:user_repository/src/models/permission.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.isActive,
    required this.is2FAEnabled,
    required this.fbUids,
    required this.phoneNumber,
    required this.name,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.unit,
    this.parentUnit,
    required this.permissions,
  });

  static const User empty = User(
    id: '',
    username: '',
    isActive: false,
    is2FAEnabled: false,
    fbUids: '',
    phoneNumber: '',
    name: '',
    createdBy: '',
    updatedBy: '',
    createdAt: '',
    updatedAt: '',
    unit: Unit.empty,
    parentUnit: null,
    permissions: const <String, Permission>{},
  );

  @JsonKey(name: "_id")
  final String id;
  final String username;
  final bool isActive;
  final bool is2FAEnabled;
  final String fbUids;
  final String phoneNumber;
  final String name;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final Unit unit;
  final Unit? parentUnit;
  final Map<String, Permission> permissions;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
        isActive,
        is2FAEnabled,
        fbUids,
        phoneNumber,
        name,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        unit,
        parentUnit,
        permissions,
      ];
}
