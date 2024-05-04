// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String,
      creatorId: json['creatorId'] as String,
      name: json['name'] as String,
      updatedAt: json['updatedAt'] as String,
      updatedBy: json['updatedBy'] as String,
      conversationUsers: (json['conversationUsers'] as List<dynamic>)
          .map((e) => ConversationUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isActive': instance.isActive,
      'name': instance.name,
      'creatorId': instance.creatorId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'conversationUsers': instance.conversationUsers,
    };
