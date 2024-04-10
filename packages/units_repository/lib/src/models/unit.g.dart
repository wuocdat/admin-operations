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
          createdBy: $checkedConvert('createdBy', (v) => v as String),
          createdAt: $checkedConvert('createdAt', (v) => v as String),
          isActive: $checkedConvert('isActive', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );
