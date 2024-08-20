// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'unit_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitNode _$UnitNodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UnitNode',
      json,
      ($checkedConvert) {
        final val = UnitNode(
          label: $checkedConvert('label', (v) => v as String),
          value: $checkedConvert('value', (v) => v as String),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => UnitNode.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$UnitNodeToJson(UnitNode instance) => <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'children': instance.children,
    };
