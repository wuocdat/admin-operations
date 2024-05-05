import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends Equatable {
  const Message({
    required this.id,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
    required this.conversationId,
    required this.content,
    required this.updatedAt,
    required this.updatedBy,
    required this.userData,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool isActive;
  final String content;
  final String conversationId;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;
  final Map<String, String> userData;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  List<Object> get props => [
        id,
        isActive,
        content,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
        conversationId,
        userData,
      ];
}
