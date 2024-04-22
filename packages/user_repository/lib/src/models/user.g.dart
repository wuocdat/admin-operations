// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      username: json['username'] as String,
      isActive: json['isActive'] as bool,
      is2FAEnabled: json['is2FAEnabled'] as bool,
      fbUids: json['fbUids'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
      parentUnit: json['parentUnit'] == null
          ? null
          : Unit.fromJson(json['parentUnit'] as Map<String, dynamic>),
      permissions: (json['permissions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Permission.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'isActive': instance.isActive,
      'is2FAEnabled': instance.is2FAEnabled,
      'fbUids': instance.fbUids,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'unit': instance.unit,
      'parentUnit': instance.parentUnit,
      'permissions': instance.permissions,
    };
