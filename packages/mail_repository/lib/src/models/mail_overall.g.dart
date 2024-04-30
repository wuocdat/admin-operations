// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_overall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailOverall _$MailOverallFromJson(Map<String, dynamic> json) => MailOverall(
      all: (json['all'] as num).toInt(),
      unread: (json['unread'] as num).toInt(),
      read: (json['read'] as num).toInt(),
    );

Map<String, dynamic> _$MailOverallToJson(MailOverall instance) =>
    <String, dynamic>{
      'all': instance.all,
      'unread': instance.unread,
      'read': instance.read,
    };
