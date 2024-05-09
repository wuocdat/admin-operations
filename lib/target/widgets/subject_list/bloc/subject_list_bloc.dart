import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subject_list_event.dart';
part 'subject_list_state.dart';

class SubjectListBloc extends Bloc<SubjectListEvent, SubjectListState> {
  SubjectListBloc() : super(SubjectListInitial()) {
    on<SubjectListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
