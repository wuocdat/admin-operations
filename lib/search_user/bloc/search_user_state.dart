part of 'search_user_bloc.dart';

class SearchUserState extends Equatable {
  const SearchUserState({
    this.users = const [],
    this.pickedUsers = const [],
    this.status = FetchDataStatus.initial,
    this.groupMode = false,
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;
  final bool groupMode;
  final List<ShortProfile> pickedUsers;

  SearchUserState copyWith({
    List<ShortProfile>? users,
    List<ShortProfile>? pickedUsers,
    FetchDataStatus? status,
    bool? groupMode,
  }) {
    return SearchUserState(
      users: users ?? this.users,
      status: status ?? this.status,
      groupMode: groupMode ?? this.groupMode,
      pickedUsers: pickedUsers ?? this.pickedUsers,
    );
  }

  @override
  List<Object> get props => [users, status, groupMode, pickedUsers];
}
