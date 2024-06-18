part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.index = 0,
    this.unReadTaskNum = 0,
    this.unReadMailNum = 0,
  });

  final int index;
  final int unReadTaskNum;
  final int unReadMailNum;

  HomeState copyWith({
    int? index,
    int? unReadTaskNum,
    int? unReadMailNum,
  }) {
    return HomeState(
      index: index ?? this.index,
      unReadTaskNum: unReadTaskNum ?? this.unReadTaskNum,
      unReadMailNum: unReadMailNum ?? this.unReadMailNum,
    );
  }

  @override
  List<Object> get props => [index, unReadTaskNum, unReadMailNum];
}
