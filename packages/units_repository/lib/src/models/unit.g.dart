// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unit _$UnitFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Unit',
      json,
      ($checkedConvert) {
        final val = Unit(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          type: $checkedConvert('type', (v) => v as Map<String, dynamic>),
          createdBy: $checkedConvert('createdBy', (v) => v as String),
          createdAt: $checkedConvert('createdAt', (v) => v as String),
          isActive: $checkedConvert('isActive', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'isActive': instance.isActive,
    };
