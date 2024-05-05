import 'package:intl/intl.dart';

final class TimeUtils {
  static String formatTime(String iso) {
    final date = DateTime.parse(iso);

    // Intl.defaultLocale = 'vi';

    return DateFormat.yMd().add_jm().format(date);
  }
}
