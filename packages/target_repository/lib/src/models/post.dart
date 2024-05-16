import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:target_repository/src/models/enums.dart';

part 'post.g.dart';

@JsonSerializable()
final class Post extends Equatable {
  const Post({
    required this.id,
    this.uid,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.link,
    required this.fbSubject,
    required this.content,
    required this.time,
    required this.unformattedTime,
    required this.commentTotal,
    required this.shareTotal,
    required this.reactionTotal,
    required this.person,
    required this.location,
    required this.organization,
    required this.processingStatus,
    required this.rate,
    required this.sentiment,
  });

  final String link;
  final String? uid;
  final Map<String, dynamic> fbSubject;
  final String content;
  final String time;
  final String unformattedTime;
  final String commentTotal;
  final String shareTotal;
  final String reactionTotal;
  final String person;
  final String location;
  final String organization;
  final int processingStatus;
  final PostRate rate;
  final PostSentiment sentiment;
  @JsonKey(name: '_id')
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  static const empty = Post(
    id: '',
    uid: '',
    link: '',
    createdBy: '',
    updatedBy: '',
    createdAt: '',
    updatedAt: '',
    fbSubject: {},
    content: '',
    time: '',
    unformattedTime: '',
    commentTotal: '',
    shareTotal: '',
    reactionTotal: '',
    person: '',
    location: '',
    organization: '',
    processingStatus: 0,
    rate: PostRate.notRate,
    sentiment: PostSentiment.negative,
  );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  List<Object?> get props => [
        id,
        uid,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        link,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        fbSubject,
        content,
        time,
        unformattedTime,
        commentTotal,
        shareTotal,
        reactionTotal,
        person,
        location,
        organization,
        processingStatus,
        rate,
        sentiment,
      ];
}
