import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_node.g.dart';

@JsonSerializable()
class UnitNode extends Equatable {
  const UnitNode({
    required this.label,
    required this.value,
    this.children,
  });

  final String label;
  final String value;
  final List<UnitNode>? children;

  factory UnitNode.fromJson(Map<String, dynamic> json) =>
      _$UnitNodeFromJson(json);

  Map<String, dynamic> toJson() => _$UnitNodeToJson(this);

  static const UnitNode empty = UnitNode(
    label: "",
    value: "",
  );

  @override
  List<Object?> get props => [label, value, children];
}
