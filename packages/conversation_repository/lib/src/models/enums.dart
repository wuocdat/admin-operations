import 'package:json_annotation/json_annotation.dart';

enum EMessageType {
  @JsonValue('video')
  video,
  @JsonValue('image')
  image,
  @JsonValue('text')
  text
}

extension EMessageTypeX on EMessageType {
  bool get isMediaType {
    return this != EMessageType.text;
  }
}
