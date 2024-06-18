import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState()) {
    on<AppNavigatedOnLaunchEvent>(_onAppNavigatedOnLaunch);
  }

  void _onAppNavigatedOnLaunch(
      AppNavigatedOnLaunchEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(hasNavigatedOnLaunchApp: true));
  }
}
