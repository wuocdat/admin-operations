// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationUser _$ConversationUserFromJson(Map<String, dynamic> json) =>
    ConversationUser(
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String,
      userId: json['userId'] as String,
      conversationId: json['conversationId'] as String,
      updatedAt: json['updatedAt'] as String,
      updatedBy: json['updatedBy'] as String,
      adderId: json['adderId'] as String,
    );

Map<String, dynamic> _$ConversationUserToJson(ConversationUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isActive': instance.isActive,
      'userId': instance.userId,
      'adderId': instance.adderId,
      'conversationId': instance.conversationId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
    };
