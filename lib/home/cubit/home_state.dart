part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.index = 0,
    this.hasUnreadTask = false,
  });

  final int index;
  final bool hasUnreadTask;

  HomeState copyWith({
    int? index,
    bool? hasUnreadTask,
  }) {
    return HomeState(
      index: index ?? this.index,
      hasUnreadTask: hasUnreadTask ?? this.hasUnreadTask,
    );
  }

  @override
  List<Object> get props => [index, hasUnreadTask];
}
