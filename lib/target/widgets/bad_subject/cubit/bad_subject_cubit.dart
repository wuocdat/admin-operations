import 'package:bloc/bloc.dart';

part 'bad_subject_state.dart';

class BadSubjectCubit extends Cubit<int> {
  BadSubjectCubit() : super(0);

  void changeOptionIndex(int index) {
    emit(index);
  }
}
