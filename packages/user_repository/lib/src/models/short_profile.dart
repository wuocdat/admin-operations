import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'short_profile.g.dart';

@JsonSerializable()
class ShortProfile extends Equatable {
  const ShortProfile({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.name,
    this.role,
  });

  static const ShortProfile empty = ShortProfile(
    id: '',
    username: '',
    phoneNumber: '',
    name: '',
    role: null,
  );

  @JsonKey(name: "_id")
  final String id;
  final String username;
  final String phoneNumber;
  final String name;
  @JsonKey(fromJson: _fromJson)
  final String? role;

  factory ShortProfile.fromJson(Map<String, dynamic> json) =>
      _$ShortProfileFromJson(json);

  @override
  List<Object?> get props => [id, username, phoneNumber, name, role];

  static String _fromJson(dynamic value) {
    final json = value as Map<String, dynamic>;
    return json['_id'] as String;
  }
}
