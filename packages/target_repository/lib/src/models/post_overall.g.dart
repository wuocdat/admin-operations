// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_overall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOverall _$PostOverallFromJson(Map<String, dynamic> json) => PostOverall(
      days: (json['days'] as List<dynamic>).map((e) => e as String).toList(),
      values: (json['values'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PostOverallToJson(PostOverall instance) =>
    <String, dynamic>{
      'days': instance.days,
      'values': instance.values,
    };
