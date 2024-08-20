import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'sent_mail_detail_state.dart';

class SentMailDetailCubit extends Cubit<SentMailDetailState> {
  SentMailDetailCubit(
      {required MailRepository mailRepository, required String mailId})
      : _mailRepository = mailRepository,
        _mailId = mailId,
        super(const SentMailDetailState());

  final MailRepository _mailRepository;
  final String _mailId;

  Future<void> fetchMail() async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final mailDetail = await _mailRepository.getSentMailDetail(_mailId);

      emit(state.copyWith(status: FetchDataStatus.success, mail: mailDetail));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
