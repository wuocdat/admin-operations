import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:mail_repository/src/models/models.dart';

const mailLimit = 20;

class MailRepository {
  MailRepository({MailApiClient? mailApiClient})
      : _mailApiClient = mailApiClient ?? MailApiClient();

  final MailApiClient _mailApiClient;
  final _controller = StreamController<MailOverall>();

  Stream<MailOverall> get overall async* {
    final overall = await _mailApiClient.getOverall();

    yield MailOverall.fromJson(overall);

    yield* _controller.stream.asBroadcastStream();
  }

  Future<Mail?> getNewestMail() async {
    //mocked data
    return const Mail(
      content:
          'Kình gửi XXX, thông tin liên quan đến đối tượng Nguyễn Lân Thắng. Hồ sơ đối tượng trong file đính kèm....',
      createdAt: 'Hôm nay, 6:20pm',
      createdBy: {},
      files: [],
      important: false,
      id: 'id',
      name: 'Report mục tiêu',
      read: false,
      updatedAt: 'updatedAt',
      updatedBy: 'updatedBy',
    );
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
