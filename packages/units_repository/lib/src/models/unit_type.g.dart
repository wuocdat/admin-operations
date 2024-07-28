// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'unit_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitType _$UnitTypeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UnitType',
      json,
      ($checkedConvert) {
        final val = UnitType(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          children: $checkedConvert('childrens',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          same: $checkedConvert('same',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id', 'children': 'childrens'},
    );

Map<String, dynamic> _$UnitTypeToJson(UnitType instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'same': instance.same,
      'childrens': instance.children,
    };
