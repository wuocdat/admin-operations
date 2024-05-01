// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortProfile _$ShortProfileFromJson(Map<String, dynamic> json) => ShortProfile(
      id: json['_id'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ShortProfileToJson(ShortProfile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
    };
