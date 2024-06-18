import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  const NotificationData({
    required this.data,
    required this.type,
  });

  final String type;
  final String data;

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      data: json['data'] as String,
      type: json['type'] as String,
    );
  }

  @override
  List<Object?> get props => [type, data];
}
