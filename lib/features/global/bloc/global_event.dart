part of 'global_bloc.dart';

sealed class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

final class AppNavigatedOnLaunchEvent extends GlobalEvent {
  const AppNavigatedOnLaunchEvent();

  @override
  List<Object> get props => [];
}
