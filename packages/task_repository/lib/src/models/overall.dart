import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overall.g.dart';

@JsonSerializable()
class Overall extends Equatable {
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

  @override
  List<Object> get props => [all, finished, unfinished, unread];
}
