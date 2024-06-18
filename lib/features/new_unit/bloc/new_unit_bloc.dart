import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_unit_event.dart';
part 'new_unit_state.dart';

class NewUnitBloc extends Bloc<NewUnitEvent, NewUnitState> {
  NewUnitBloc() : super(NewUnitInitial()) {
    on<NewUnitEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
