// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['_id'] as String,
      uid: json['uid'] as String?,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      link: json['link'] as String,
      fbSubject: json['fbSubject'] as Map<String, dynamic>,
      content: json['content'] as String,
      time: json['time'] as String,
      unformattedTime: json['unformattedTime'] as String,
      commentTotal: json['commentTotal'] as String,
      shareTotal: json['shareTotal'] as String,
      reactionTotal: json['reactionTotal'] as String,
      person: json['person'] as String,
      location: json['location'] as String,
      organization: json['organization'] as String,
      processingStatus: (json['processingStatus'] as num).toInt(),
      rate: $enumDecode(_$PostRateEnumMap, json['rate']),
      sentiment: $enumDecode(_$PostSentimentEnumMap, json['sentiment']),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'link': instance.link,
      'uid': instance.uid,
      'fbSubject': instance.fbSubject,
      'content': instance.content,
      'time': instance.time,
      'unformattedTime': instance.unformattedTime,
      'commentTotal': instance.commentTotal,
      'shareTotal': instance.shareTotal,
      'reactionTotal': instance.reactionTotal,
      'person': instance.person,
      'location': instance.location,
      'organization': instance.organization,
      'processingStatus': instance.processingStatus,
      'rate': _$PostRateEnumMap[instance.rate]!,
      'sentiment': _$PostSentimentEnumMap[instance.sentiment]!,
      '_id': instance.id,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$PostRateEnumMap = {
  PostRate.notRate: 0,
  PostRate.oneStar: 1,
  PostRate.twoStar: 2,
  PostRate.threeStar: 3,
  PostRate.fourStar: 4,
  PostRate.fiveStar: 5,
};

const _$PostSentimentEnumMap = {
  PostSentiment.positive: '0',
  PostSentiment.negative: '1',
  PostSentiment.unscored: '2',
};
