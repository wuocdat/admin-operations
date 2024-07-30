import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mail_container_event.dart';
part 'mail_container_state.dart';

class MailContainerBloc extends Bloc<MailContainerEvent, MailContainerState> {
  MailContainerBloc() : super(const MailContainerState.receiver()) {
    on<ChangeModeEvent>(_onChangeMode);
  }

  void _onChangeMode(ChangeModeEvent event, Emitter<MailContainerState> emit) {
    emit(event.mode.isReceiverMode
        ? const MailContainerState.receiver()
        : const MailContainerState.sender());
  }
}

extension MailOptionsX on MailOptions {
  String get title {
    if (this == MailOptions.receivedMail) {
      return "Thư đến";
    } else {
      return "Thư đi";
    }
  }

  bool get isReceiverMode => this == MailOptions.receivedMail;
}
