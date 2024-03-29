import 'package:json_annotation/json_annotation.dart';

part 'overall.g.dart';

@JsonSerializable()
class Overall {
  const Overall({
    required this.all,
    required this.finished,
    required this.unfinished,
    required this.unread,
  });

  final int all;
  final int finished;
  final int unfinished;
  final int unread;

  factory Overall.fromJson(Map<String, dynamic> json) =>
      _$OverallFromJson(json);
}
