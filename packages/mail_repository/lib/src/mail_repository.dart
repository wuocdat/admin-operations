import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:mail_repository/src/models/mail_overall.dart';

class MailRepository {
  MailRepository({MailApiClient? mailApiClient})
      : _mailApiClient = mailApiClient ?? MailApiClient();

  final MailApiClient _mailApiClient;
  final _controller = StreamController<MailOverall>();

  Stream<MailOverall> get overall async* {
    final overall = await _mailApiClient.getOverall();

    yield MailOverall.fromJson(overall);

    yield* _controller.stream;
  }
}
