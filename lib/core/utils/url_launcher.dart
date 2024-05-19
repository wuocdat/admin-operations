import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchLink(String link) async {
  final Uri url = Uri.parse(link);

  if (!await launchUrl(url)) logger.e('could not launch $url');
}
