// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      skills: json['skills'] as String?,
      lastWork: json['lastWork'] as String?,
      introduce: json['introduce'] as String?,
      favorite: json['favorite'] as String?,
      religion: json['religion'] as String?,
      political: json['political'] as String?,
      relationship: json['relationship'] as String?,
      hometown: json['hometown'] as String?,
      education: json['education'] as String?,
      location: json['location'] as String?,
      createdTime: json['createdTime'] as String?,
      birthYear: json['birthYear'] as String?,
      phone: json['phone'] as String?,
      following: json['following'] as String?,
      followers: json['followers'] as String?,
      name: json['name'] as String?,
      informalName: json['informalName'] as String?,
      id: json['_id'] as String,
      uid: json['uid'] as String,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isActive: json['isActive'] as bool,
      isTracking: json['isTracking'] as bool,
      unit: (json['unit'] as List<dynamic>).map((e) => e as String).toList(),
      type: Subject._fromJson(json['type']),
      typeAc: Subject._fromJson(json['typeAc']),
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'skills': instance.skills,
      'lastWork': instance.lastWork,
      'introduce': instance.introduce,
      'favorite': instance.favorite,
      'religion': instance.religion,
      'political': instance.political,
      'relationship': instance.relationship,
      'hometown': instance.hometown,
      'education': instance.education,
      'location': instance.location,
      'createdTime': instance.createdTime,
      'birthYear': instance.birthYear,
      'phone': instance.phone,
      'following': instance.following,
      'followers': instance.followers,
      'name': instance.name,
      '_id': instance.id,
      'informalName': instance.informalName,
      'uid': instance.uid,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isActive': instance.isActive,
      'isTracking': instance.isTracking,
      'unit': instance.unit,
      'type': instance.type,
      'typeAc': instance.typeAc,
    };
