part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.index = 0,
    this.unReadTaskNum = 0,
    this.unReadMailNum = 0,
    this.notificationData,
  });

  final int index;
  final int unReadTaskNum;
  final int unReadMailNum;
  final NotificationData? notificationData;

  HomeState copyWith({
    int? index,
    int? unReadTaskNum,
    int? unReadMailNum,
    NotificationData? notificationData,
  }) {
    return HomeState(
      index: index ?? this.index,
      unReadTaskNum: unReadTaskNum ?? this.unReadTaskNum,
      unReadMailNum: unReadMailNum ?? this.unReadMailNum,
      notificationData: notificationData ?? this.notificationData,
    );
  }

  @override
  List<Object?> get props => [
        index,
        unReadTaskNum,
        unReadMailNum,
        notificationData,
      ];
}
