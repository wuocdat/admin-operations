import 'package:conversation_repository/src/models/conversation_user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation extends Equatable {
  const Conversation({
    required this.id,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
    required this.creatorId,
    required this.name,
    required this.updatedAt,
    required this.updatedBy,
    required this.conversationUsers,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool isActive;
  final String name;
  final String creatorId;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;
  final List<ConversationUser> conversationUsers;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  @override
  List<Object> get props => [
        id,
        isActive,
        name,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
        creatorId,
        conversationUsers,
      ];
}
