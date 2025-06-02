// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: json['_id'] as String,
      name: json['name'] as String?,
      conversationUsers: (json['conversationUsers'] as List<dynamic>)
          .map((e) => ConversationUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessageCreatedAt: json['lastMessageCreatedAt'] as String?,
      lastestMessage: json['lastestMessage'] == null
          ? null
          : Message.fromJson(json['lastestMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'conversationUsers': instance.conversationUsers,
      'lastestMessage': instance.lastestMessage,
      'lastMessageCreatedAt': instance.lastMessageCreatedAt,
    };
