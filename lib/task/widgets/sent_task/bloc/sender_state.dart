part of 'sender_bloc.dart';

enum Owner { me, others }

extension OwnerX on Owner {
  String get title {
    switch (this) {
      case Owner.me:
        return "Trực tiếp";
      case Owner.others:
        return "Tất cả";
    }
  }

  String get query {
    switch (this) {
      case Owner.me:
        return "me";
      case Owner.others:
        return "others";
    }
  }
}

class SenderState extends Equatable {
  const SenderState({
    this.owner = Owner.me,
    this.searchValue,
    this.hasReachedMax = false,
    this.status = FetchDataStatus.initial,
    this.tasks = const <Task>[],
  });

  final Owner owner;
  final String? searchValue;
  final FetchDataStatus status;
  final List<Task> tasks;
  final bool hasReachedMax;

  SenderState copyWith({
    Owner? owner,
    String? searchValue,
    FetchDataStatus? status,
    List<Task>? tasks,
    bool? hasReachedMax,
  }) {
    return SenderState(
      owner: owner ?? this.owner,
      searchValue: searchValue ?? this.searchValue,
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [owner, searchValue, status, tasks, hasReachedMax];
}
