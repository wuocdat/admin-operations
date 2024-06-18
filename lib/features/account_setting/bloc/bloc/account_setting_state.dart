part of 'account_setting_bloc.dart';

sealed class AccountSettingState extends Equatable {
  const AccountSettingState();
  
  @override
  List<Object> get props => [];
}

final class AccountSettingInitial extends AccountSettingState {}
