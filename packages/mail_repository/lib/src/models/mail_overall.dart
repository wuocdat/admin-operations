import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mail_overall.g.dart';

@JsonSerializable()
final class MailOverall extends Equatable {
  const MailOverall({
    required this.all,
    required this.unread,
    required this.read,
  });

  final int all;
  final int unread;
  final int read;

  static const empty = MailOverall(all: 0, unread: 0, read: 0);

  factory MailOverall.fromJson(Map<String, dynamic> json) =>
      _$MailOverallFromJson(json);

  @override
  List<Object> get props => [all, unread, read];
}
