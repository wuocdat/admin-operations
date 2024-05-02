import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:mail_repository/src/models/models.dart';

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
}
