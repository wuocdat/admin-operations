part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.index = 0,
    this.unReadTaskNum = 0,
  });

  final int index;
  final int unReadTaskNum;

  HomeState copyWith({
    int? index,
    int? unReadTaskNum,
  }) {
    return HomeState(
      index: index ?? this.index,
      unReadTaskNum: unReadTaskNum ?? this.unReadTaskNum,
    );
  }

  @override
  List<Object> get props => [index, unReadTaskNum];
}
