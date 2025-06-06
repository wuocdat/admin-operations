import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'progress_detail.g.dart';

@JsonSerializable()
class ProgressDetail extends Equatable {
  const ProgressDetail({
    required this.id,
    required this.isActive,
    required this.content,
    required this.unit,
    required this.files,
    required this.createdBy,
    required this.createdAt,
    required this.repeat,
    required this.status,
    required this.task,
    this.total,
  });

  @JsonKey(name: "_id")
  final String id;
  final bool isActive;
  final String content;
  final String unit;
  final List<String> files;
  final Map<String, String> createdBy;
  final String createdAt;
  final int repeat;
  final Map<String, String> status;
  final String task;
  final int? total;

  factory ProgressDetail.fromJson(Map<String, dynamic> json) =>
      _$ProgressDetailFromJson(json);

  ProgressDetail copyWith({
    String? id,
    bool? isActive,
    String? content,
    String? unit,
    List<String>? files,
    Map<String, String>? createdBy,
    String? createdAt,
    int? repeat,
    Map<String, String>? status,
    String? task,
    int? total,
  }) {
    return ProgressDetail(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      content: content ?? this.content,
      unit: unit ?? this.unit,
      files: files ?? this.files,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      repeat: repeat ?? this.repeat,
      status: status ?? this.status,
      task: task ?? this.task,
      total: total ?? this.total,
    );
  }

  static const empty = ProgressDetail(
    id: '',
    isActive: false,
    content: '',
    unit: '',
    files: [],
    createdBy: {},
    createdAt: '',
    repeat: 0,
    status: {},
    task: '',
  );

  @override
  List<Object?> get props => [
        id,
        isActive,
        content,
        unit,
        files,
        createdBy,
        createdAt,
        repeat,
        status,
        task,
        total,
      ];
}
