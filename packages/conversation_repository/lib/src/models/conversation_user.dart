import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_user.g.dart';

@JsonSerializable()
class ConversationUser extends Equatable {
  const ConversationUser({
    required this.id,
    required this.isActive,
    required this.userId,
    required this.conversationId,
    required this.adderId,
    required this.userDetail,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool isActive;
  final String userId;
  final String adderId;
  final String conversationId;
  @JsonKey(fromJson: _fromJson)
  final Map<String, dynamic> userDetail;

  factory ConversationUser.fromJson(Map<String, dynamic> json) =>
      _$ConversationUserFromJson(json);

  @override
  List<Object> get props => [
    id,
    isActive,
    userId,
    adderId,
    conversationId,
    userDetail,
  ];

  static Map<String, dynamic> _fromJson(dynamic value) {
    if (value == null) {
      return {
        "_id": "",
        "name": "noname",
      };
    }
    return value as Map<String, dynamic>;
  }
}

