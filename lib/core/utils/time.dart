import 'package:intl/intl.dart';

final class TimeUtils {
  static String formatTime(String iso) {
    final date = DateTime.parse(iso).toLocal();

    return DateFormat.yMd().add_jm().format(date);
  }

  static String convertTimeToReadableFormat(String iso) {
    final inputDate = DateTime.parse(iso).toLocal();

    final currentYMD = DateFormat.yMd().format(DateTime.now());
    final inputYMD = DateFormat.yMd().format(inputDate);

    return (currentYMD == inputYMD)
        ? DateFormat.jm().format(inputDate)
        : inputYMD;
  }

  static String formatByYMD(String iso) {
    final date = DateTime.parse(iso).toLocal();

    return DateFormat.yMd().format(date);
  }

  static String getTimeStamp() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
