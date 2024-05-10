import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
final class Subject extends Equatable {
  const Subject({
    this.skills,
    this.lastWork,
    this.introduce,
    this.favorite,
    this.religion,
    this.political,
    this.relationship,
    this.hometown,
    this.education,
    this.location,
    this.createdTime,
    this.birthYear,
    this.phone,
    this.following,
    this.followers,
    this.name,
    this.informalName,
    required this.id,
    required this.uid,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isTracking,
    required this.unit,
    required this.type,
    required this.typeAc,
  });

  final String? skills;
  final String? lastWork;
  final String? introduce;
  final String? favorite;
  final String? religion;
  final String? political;
  final String? relationship;
  final String? hometown;
  final String? education;
  final String? location;
  final String? createdTime;
  final String? birthYear;
  final String? phone;
  final String? following;
  final String? followers;
  final String? name;
  @JsonKey(name: '_id')
  final String id;
  final String? informalName;
  final String uid;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final bool isActive;
  final bool isTracking;
  final List<String> unit;
  @JsonKey(fromJson: _fromJson)
  final String type;
  @JsonKey(fromJson: _fromJson)
  final String typeAc;

  static const empty = Subject(
    id: '',
    uid: '',
    createdBy: '',
    updatedBy: '',
    createdAt: '',
    updatedAt: '',
    isActive: false,
    isTracking: false,
    unit: [],
    type: '',
    typeAc: '',
  );

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  @override
  List<Object> get props => [
        id,
        uid,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        isActive,
        isTracking,
        unit,
        type,
        typeAc,
      ];

  static String _fromJson(dynamic value) {
    final json = value as Map<String, dynamic>;
    return json['_id'] as String;
  }
}
