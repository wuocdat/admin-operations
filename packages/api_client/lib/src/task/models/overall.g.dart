// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'overall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Overall _$OverallFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Overall',
      json,
      ($checkedConvert) {
        final val = Overall(
          all: $checkedConvert('all', (v) => v as int),
          finished: $checkedConvert('finished', (v) => v as int),
          unfinished: $checkedConvert('unfinished', (v) => v as int),
          unread: $checkedConvert('unread', (v) => v as int),
        );
        return val;
      },
    );
