import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'member_manager_event.dart';
part 'member_manager_state.dart';

class MemberManagerBloc extends Bloc<MemberManagerEvent, MemberManagerState> {
  MemberManagerBloc() : super(MemberManagerInitial()) {
    on<MemberManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
