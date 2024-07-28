import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_type.g.dart';

@JsonSerializable()
class UnitType extends Equatable {
  const UnitType({
    required this.id,
    required this.name,
    required this.children,
    required this.same,
  });

  @JsonKey(name: "_id")
  final String id;
  final String name;
  final List<String> same;
  @JsonKey(name: "childrens")
  final List<String> children;

  factory UnitType.fromJson(Map<String, dynamic> json) =>
      _$UnitTypeFromJson(json);

  Map<String, dynamic> toJson() => _$UnitTypeToJson(this);

  static const UnitType empty = UnitType(
    id: "",
    name: "",
    children: [],
    same: [],
  );

  @override
  List<Object> get props => [id, name, children, same];
}
