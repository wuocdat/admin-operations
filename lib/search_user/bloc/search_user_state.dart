part of 'search_user_bloc.dart';

enum CreateConversationStatus { initial, loading, success }

class SearchUserState extends Equatable {
  const SearchUserState({
    this.users = const [],
    this.pickedUsers = const [],
    this.status = FetchDataStatus.initial,
    this.groupMode = false,
    this.creatingStatus = CreateConversationStatus.initial,
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;
  final bool groupMode;
  final List<ShortProfile> pickedUsers;
  final CreateConversationStatus creatingStatus;

  SearchUserState copyWith({
    List<ShortProfile>? users,
    List<ShortProfile>? pickedUsers,
    FetchDataStatus? status,
    bool? groupMode,
    CreateConversationStatus? creatingStatus,
  }) {
    return SearchUserState(
      users: users ?? this.users,
      status: status ?? this.status,
      groupMode: groupMode ?? this.groupMode,
      pickedUsers: pickedUsers ?? this.pickedUsers,
      creatingStatus: creatingStatus ?? this.creatingStatus,
    );
  }

  @override
  List<Object> get props => [
        users,
        status,
        groupMode,
        pickedUsers,
        creatingStatus,
      ];
}
