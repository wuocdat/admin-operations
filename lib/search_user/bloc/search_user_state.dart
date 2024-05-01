part of 'search_user_bloc.dart';

class SearchUserState extends Equatable {
  const SearchUserState({
    this.users = const [],
    this.status = FetchDataStatus.initial,
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;

  SearchUserState copyWith({
    List<ShortProfile>? users,
    FetchDataStatus? status,
  }) {
    return SearchUserState(
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [users, status];
}
