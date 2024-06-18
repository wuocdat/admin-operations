import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

final class PermissionsHelper {
  static Future<bool> checkAndRequestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      debugPrint('status: ${status.isGranted}');
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }
}
