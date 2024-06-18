part of 'search_user_bloc.dart';

enum CreateConversationStatus { initial, loading, success }

extension CreateConversationStatusX on CreateConversationStatus {
  bool get isLoading => this == CreateConversationStatus.loading;

  bool get isSuccess => this == CreateConversationStatus.success;
}

class SearchUserState extends Equatable {
  const SearchUserState({
    this.users = const [],
    this.pickedUsers = const [],
    this.status = FetchDataStatus.initial,
    this.groupMode = false,
    this.creatingStatus = CreateConversationStatus.initial,
    this.conversationId,
    this.hasReachedMax = true,
    this.searchValue = "",
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;
  final bool groupMode;
  final List<ShortProfile> pickedUsers;
  final CreateConversationStatus creatingStatus;
  final String? conversationId;
  final bool hasReachedMax;
  final String searchValue;

  SearchUserState copyWith({
    List<ShortProfile>? users,
    List<ShortProfile>? pickedUsers,
    FetchDataStatus? status,
    bool? groupMode,
    CreateConversationStatus? creatingStatus,
    String? conversationId,
    bool? hasReachedMax,
    String? searchValue,
  }) {
    return SearchUserState(
      users: users ?? this.users,
      status: status ?? this.status,
      groupMode: groupMode ?? this.groupMode,
      pickedUsers: pickedUsers ?? this.pickedUsers,
      creatingStatus: creatingStatus ?? this.creatingStatus,
      conversationId: conversationId ?? this.conversationId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchValue: searchValue ?? this.searchValue,
    );
  }

  @override
  List<Object?> get props => [
        users,
        status,
        groupMode,
        pickedUsers,
        creatingStatus,
        conversationId,
        hasReachedMax,
        searchValue,
      ];
}
