part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class SearchInputChangeEvent extends SearchUserEvent {
  const SearchInputChangeEvent(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
