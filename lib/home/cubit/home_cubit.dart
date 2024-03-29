import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  void changeIndex(int index) => emit(index);
}
