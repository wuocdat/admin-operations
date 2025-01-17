import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:mail_repository/src/models/models.dart';

const mailLimit = 20;

class MailRepository {
  MailRepository({MailApiClient? mailApiClient})
      : _mailApiClient = mailApiClient ?? MailApiClient();

  final MailApiClient _mailApiClient;
  final _controller = StreamController<MailOverall>.broadcast();

  Stream<MailOverall> get overall async* {
    final overall = await _mailApiClient.getOverall();

    yield MailOverall.fromJson(overall);

    yield* _controller.stream.asBroadcastStream();
  }

  Future<void> updateOverall() async {
    final overall = await _mailApiClient.getOverall();
    _controller.add(MailOverall.fromJson(overall));
  }

  Future<Mail?> getNewestMail() async {
    final mailJson = await _mailApiClient.getNewestMail();

    return mailJson != null ? Mail.fromJson(mailJson) : null;
  }

  Future<List<Mail>> fetchReceivedMails([int mailLength = 0]) async {
    final mailsJson = await _mailApiClient.getReceivedMails(
        mailLimit, (mailLength / mailLimit).ceil() + 1);

    return mailsJson.map((e) => Mail.fromJson(e)).toList();
  }

  Future<List<SentMailType>> fetchSentMails([int mailLength = 0]) async {
    final mailsJson = await _mailApiClient.getSentMails(
        mailLimit, (mailLength / mailLimit).ceil() + 1);

    return mailsJson.map((e) => SentMailType.fromJson(e)).toList();
  }

  Future<Mail> getReceivedMailDetail(String mailId) async {
    final mailJson = await _mailApiClient.getReceivedMailDetail(mailId);
    final overall = await _mailApiClient.getOverall();
    _controller.add(MailOverall.fromJson(overall));

    return Mail.fromJson(mailJson);
  }

  Future<SentMailType> getSentMailDetail(String mailId) async {
    final mailJson = await _mailApiClient.getSentMailDetail(mailId);

    return SentMailType.fromJson(mailJson);
  }

  Future<void> sentMail(
    String name,
    String content,
    List<String> units,
    bool important,
    List<String> filePaths,
  ) async {
    await _mailApiClient.createMail(name, content, important, units, filePaths);
  }
}
