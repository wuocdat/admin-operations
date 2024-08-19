import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'sent_mail_event.dart';
part 'sent_mail_state.dart';

class SentMailBloc extends Bloc<SentMailEvent, SentMailState> {
  SentMailBloc({required MailRepository mailRepository})
      : _mailRepository = mailRepository,
        super(const SentMailState()) {
    on<SentMailsFetchedEvent>(_onSentMailsFetched);
    on<SentMailsResetEvent>(_onReload);
  }

  final MailRepository _mailRepository;

  Future<void> _onSentMailsFetched(
      SentMailsFetchedEvent event, Emitter<SentMailState> emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final mails = await _mailRepository.fetchSentMails(
        state.mails.length,
      );

      mails.length < mailLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              mails: List.of(state.mails)..addAll(mails),
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              mails: List.of(state.mails)..addAll(mails),
            ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onReload(
    SentMailsResetEvent event,
    Emitter<SentMailState> emit,
  ) async {
    emit(state.copyWith(
        status: FetchDataStatus.loading, mails: List<SentMailType>.empty()));

    try {
      final mails = await _mailRepository.fetchSentMails();
      emit(state.copyWith(
        status: FetchDataStatus.success,
        mails: mails,
        hasReachedMax: mails.length < mailLimit,
      ));
    } catch (_) {
      emit(state.copyWith(
          status: FetchDataStatus.failure, mails: List<SentMailType>.empty()));
    }
  }
}
