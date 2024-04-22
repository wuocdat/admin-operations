// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Overall _$OverallFromJson(Map<String, dynamic> json) => Overall(
      all: json['all'] as int,
      finished: json['finished'] as int,
      unfinished: json['unfinished'] as int,
      unread: json['unread'] as int,
    );

Map<String, dynamic> _$OverallToJson(Overall instance) => <String, dynamic>{
      'all': instance.all,
      'finished': instance.finished,
      'unfinished': instance.unfinished,
      'unread': instance.unread,
    };
