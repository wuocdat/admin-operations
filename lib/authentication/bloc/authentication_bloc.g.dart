// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AuthenticationState',
      json,
      ($checkedConvert) {
        final val = AuthenticationState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$AuthenticationStatusEnumMap, v) ??
                  AuthenticationStatus.unknown),
          user: $checkedConvert(
              'user',
              (v) => v == null
                  ? User.empty
                  : User.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'status': _$AuthenticationStatusEnumMap[instance.status]!,
      'user': instance.user.toJson(),
    };

const _$AuthenticationStatusEnumMap = {
  AuthenticationStatus.unknown: 'unknown',
  AuthenticationStatus.authenticated: 'authenticated',
  AuthenticationStatus.unauthenticated: 'unauthenticated',
};
