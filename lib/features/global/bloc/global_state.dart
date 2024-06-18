part of 'global_bloc.dart';

class GlobalState extends Equatable {
  const GlobalState({
    this.hasNavigatedOnLaunchApp = false,
  });

  final bool hasNavigatedOnLaunchApp;

  GlobalState copyWith({
    bool? hasNavigatedOnLaunchApp,
  }) {
    return GlobalState(
      hasNavigatedOnLaunchApp:
          hasNavigatedOnLaunchApp ?? this.hasNavigatedOnLaunchApp,
    );
  }

  @override
  List<Object> get props => [hasNavigatedOnLaunchApp];
}
