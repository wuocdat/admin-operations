import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'received_mail_detail_state.dart';

class ReceivedMailDetailCubit extends Cubit<ReceivedMailDetailState> {
  ReceivedMailDetailCubit(
      {required MailRepository mailRepository, required String mailId})
      : _mailRepository = mailRepository,
        _mailId = mailId,
        super(const ReceivedMailDetailState());

  final MailRepository _mailRepository;
  final String _mailId;

  Future<void> fetchMail() async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final mailDetail = await _mailRepository.getReceivedMailDetail(_mailId);

      emit(state.copyWith(status: FetchDataStatus.success, mail: mailDetail));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
