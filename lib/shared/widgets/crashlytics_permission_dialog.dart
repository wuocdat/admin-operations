import 'package:flutter/material.dart';
import 'package:tctt_mobile/core/services/firebase_service.dart';

class CrashlyticsPermissionDialog extends StatelessWidget {
  const CrashlyticsPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Thu Thập Dữ Liệu Lỗi"),
      content: const Text(
          "Cho phép thu thập dữ liệu lỗi để cải thiện ứng dụng? Bạn có thể thay đổi tùy chọn trong phần Cài đặt sau này."),
      actions: [
        TextButton(
          onPressed: () async {
            await CrashlyticsService.setCrashlyticsEnabled(false);
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Không"),
        ),
        ElevatedButton(
          onPressed: () async {
            await CrashlyticsService.setCrashlyticsEnabled(true);
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Cho phép"),
        ),
      ],
    );
  }
}
