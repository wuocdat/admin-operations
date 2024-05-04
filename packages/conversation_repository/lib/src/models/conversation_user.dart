import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_user.g.dart';

@JsonSerializable()
class ConversationUser extends Equatable {
  const ConversationUser({
    required this.id,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
    required this.userId,
    required this.conversationId,
    required this.updatedAt,
    required this.updatedBy,
    required this.adderId,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool isActive;
  final String userId;
  final String adderId;
  final String conversationId;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  factory ConversationUser.fromJson(Map<String, dynamic> json) =>
      _$ConversationUserFromJson(json);

  @override
  List<Object> get props => [
        id,
        isActive,
        userId,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
        adderId,
        conversationId,
      ];
}
