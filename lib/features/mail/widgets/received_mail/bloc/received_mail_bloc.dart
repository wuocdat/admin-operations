import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'received_mail_event.dart';
part 'received_mail_state.dart';

class ReceivedMailBloc extends Bloc<ReceivedMailEvent, ReceivedMailState> {
  ReceivedMailBloc({required MailRepository mailRepository})
      : _mailRepository = mailRepository,
        super(const ReceivedMailState()) {
    on<ReceiverFetchedEvent>(_onReceiverFetched);
    on<ReceiverResetEvent>(_onReload);
  }

  final MailRepository _mailRepository;

  Future<void> _onReceiverFetched(
      ReceiverFetchedEvent event, Emitter<ReceivedMailState> emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final mails = await _mailRepository.fetchReceivedMails(
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
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onReload(
    ReceiverResetEvent event,
    Emitter<ReceivedMailState> emit,
  ) async {
    emit(state.copyWith(
        status: FetchDataStatus.loading, mails: List<Mail>.empty()));

    try {
      final mails = await _mailRepository.fetchReceivedMails();
      emit(state.copyWith(
        status: FetchDataStatus.success,
        mails: mails,
        hasReachedMax: mails.length < mailLimit,
      ));
    } catch (_) {
      emit(state.copyWith(
          status: FetchDataStatus.failure, mails: List<Mail>.empty()));
    }
  }
}
