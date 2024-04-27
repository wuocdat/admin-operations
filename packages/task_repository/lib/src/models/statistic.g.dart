// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistic _$StatisticFromJson(Map<String, dynamic> json) => Statistic(
      id: json['_id'] as String,
      name: json['name'] as String,
      countMembers: json['countMembers'] as int,
      countReports: json['countReports'] as int,
      totalMembers: json['totalMembers'] as int,
      totalReports: json['totalReports'] as int,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Statistic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticToJson(Statistic instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'countMembers': instance.countMembers,
      'countReports': instance.countReports,
      'totalMembers': instance.totalMembers,
      'totalReports': instance.totalReports,
      'children': instance.children,
    };
