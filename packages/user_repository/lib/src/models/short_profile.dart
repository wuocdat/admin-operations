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
  });

  static const ShortProfile empty = ShortProfile(
    id: '',
    username: '',
    phoneNumber: '',
    name: '',
  );

  @JsonKey(name: "_id")
  final String id;
  final String username;
  final String phoneNumber;
  final String name;

  factory ShortProfile.fromJson(Map<String, dynamic> json) =>
      _$ShortProfileFromJson(json);

  @override
  List<Object> get props => [id, username, phoneNumber, name];
}
