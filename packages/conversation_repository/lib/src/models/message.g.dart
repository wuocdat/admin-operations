// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String,
      conversationId: json['conversationId'] as String,
      content: json['content'] as String?,
      updatedAt: json['updatedAt'] as String,
      updatedBy: json['updatedBy'] as String,
      userData: Message._fromJson(json['userData']),
      type: $enumDecodeNullable(_$EMessageTypeEnumMap, json['type']) ??
          EMessageType.text,
      media: json['Media'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '_id': instance.id,
      'isActive': instance.isActive,
      'content': instance.content,
      'conversationId': instance.conversationId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'userData': instance.userData,
      'type': _$EMessageTypeEnumMap[instance.type]!,
      'Media': instance.media,
    };

const _$EMessageTypeEnumMap = {
  EMessageType.video: 'video',
  EMessageType.image: 'image',
  EMessageType.text: 'text',
};
