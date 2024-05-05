// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationUser _$ConversationUserFromJson(Map<String, dynamic> json) =>
    ConversationUser(
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      userId: json['userId'] as String,
      conversationId: json['conversationId'] as String,
      adderId: json['adderId'] as String,
      userDetail: Map<String, String>.from(json['userDetail'] as Map),
    );

Map<String, dynamic> _$ConversationUserToJson(ConversationUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isActive': instance.isActive,
      'userId': instance.userId,
      'adderId': instance.adderId,
      'conversationId': instance.conversationId,
      'userDetail': instance.userDetail,
    };
