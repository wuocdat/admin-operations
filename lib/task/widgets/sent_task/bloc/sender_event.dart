part of 'sender_bloc.dart';

sealed class SenderEvent extends Equatable {
  const SenderEvent();

  @override
  List<Object> get props => [];
}

final class SenderFetchedEvent extends SenderEvent {
  const SenderFetchedEvent();

  @override
  List<Object> get props => [];
}

final class OwnerChangedEvent extends SenderEvent {
  const OwnerChangedEvent(this.owner);

  final Owner owner;

  @override
  List<Object> get props => [owner];
}

final class SearchInputChangedEvent extends SenderEvent {
  const SearchInputChangedEvent(this.searchValue);

  final String searchValue;

  @override
  List<Object> get props => [searchValue];
}
