import 'package:conversation_repository/src/models/conversation_user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation extends Equatable {
  const Conversation({
    required this.id,
    this.name,
    required this.conversationUsers,
  });

  @JsonKey(name: "_id")
  final String id;
  final String? name;
  final List<ConversationUser> conversationUsers;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  @override
  List<Object?> get props => [id, name, conversationUsers];
}
