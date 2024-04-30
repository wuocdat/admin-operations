import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:task_repository/task_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required TaskRepository taskRepository,
    required MailRepository mailRepository,
  })  : _taskRepository = taskRepository,
        _mailRepository = mailRepository,
        super(const HomeState()) {
    _taskOverallSubscription = _taskRepository.overall.listen(
        (overall) => emit(state.copyWith(unReadTaskNum: overall.unread)));
    _mailOverallSubscription = _mailRepository.overall.listen(
        (overall) => emit(state.copyWith(unReadMailNum: overall.unread)));
  }

  final TaskRepository _taskRepository;
  final MailRepository _mailRepository;
  late StreamSubscription<Overall> _taskOverallSubscription;
  late StreamSubscription<MailOverall> _mailOverallSubscription;

  @override
  Future<void> close() {
    _taskOverallSubscription.cancel();
    _mailOverallSubscription.cancel();
    return super.close();
  }

  void changeIndex(int index) => emit(state.copyWith(index: index));
}
