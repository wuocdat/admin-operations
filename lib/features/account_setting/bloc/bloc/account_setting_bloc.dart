import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_setting_event.dart';
part 'account_setting_state.dart';

class AccountSettingBloc extends Bloc<AccountSettingEvent, AccountSettingState> {
  AccountSettingBloc() : super(AccountSettingInitial()) {
    on<AccountSettingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
