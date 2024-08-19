import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sent_mail.g.dart';

@JsonSerializable()
final class SentMailType extends Equatable {
  const SentMailType({
    required this.content,
    required this.createdAt,
    required this.createdBy,
    required this.files,
    required this.important,
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.updatedBy,
    required this.receivers,
  });

  final String content;
  final String createdAt;
  final String createdBy;
  final List<String> files;
  final bool important;
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String updatedAt;
  final String updatedBy;
  final List<Map<String, dynamic>> receivers;

  static const empty = SentMailType(
    content: '',
    createdAt: '',
    createdBy: '',
    files: [],
    important: false,
    id: '',
    name: '',
    updatedAt: '',
    updatedBy: '',
    receivers: [],
  );

  factory SentMailType.fromJson(Map<String, dynamic> json) =>
      _$SentMailTypeFromJson(json);

  @override
  List<Object> get props => [
        content,
        createdAt,
        createdBy,
        files,
        important,
        id,
        name,
        updatedAt,
        updatedBy,
        receivers,
      ];
}
