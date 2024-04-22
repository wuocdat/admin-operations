import 'dart:io';

import 'package:path_provider/path_provider.dart';

final class FileHelper {
  static String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.pathSegments.last;
  }

  static Future<String> getSavePath(String filename) async {
    return (await getTemporaryDirectory()).path + filename;
  }

  static Future<String> getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }

  static bool isImageFile(String path) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    final ext = path.split('.').last;
    return imageExtensions.contains(ext);
  }
}
