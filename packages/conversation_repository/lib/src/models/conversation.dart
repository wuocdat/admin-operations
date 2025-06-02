import 'package:conversation_repository/conversation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation extends Equatable {
  const Conversation({
    required this.id,
    this.name,
    required this.conversationUsers,
    this.lastMessageCreatedAt,
    this.lastestMessage,
  });

  @JsonKey(name: "_id")
  final String id;
  final String? name;
  final List<ConversationUser> conversationUsers;
  final Message? lastestMessage;
  final String? lastMessageCreatedAt;

  static const empty = Conversation(id: "", conversationUsers: []);

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        conversationUsers,
        lastMessageCreatedAt,
        lastestMessage,
      ];
}
