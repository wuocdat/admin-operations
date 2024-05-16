import 'package:json_annotation/json_annotation.dart';

enum PostRate {
  @JsonValue(0)
  notRate,
  @JsonValue(1)
  oneStar,
  @JsonValue(2)
  twoStar,
  @JsonValue(3)
  threeStar,
  @JsonValue(4)
  fourStar,
  @JsonValue(5)
  fiveStar,
}

enum PostSentiment {
  @JsonValue("0")
  positive,
  @JsonValue('1')
  negative,
  @JsonValue('2')
  unscored,
}
