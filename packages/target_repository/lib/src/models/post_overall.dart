import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_overall.g.dart';

@JsonSerializable()
final class PostOverall extends Equatable {
  const PostOverall({
    required this.days,
    required this.values,
  });

  final List<String> days;
  final List<int> values;

  static const empty = PostOverall(days: [], values: []);

  factory PostOverall.fromJson(Map<String, dynamic> json) =>
      _$PostOverallFromJson(json);

  @override
  List<Object> get props => [values, days];
}
