import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';

class HasPermission extends StatelessWidget {
  final List<ERole> allowedRoles;
  final Widget child;
  final Widget? otherwise;

  const HasPermission({
    super.key,
    required this.allowedRoles,
    required this.child,
    this.otherwise,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    if (user.hasPermission(allowedRoles)) {
      return child;
    }
    return otherwise ?? Container();
  }
}

class CreatingPermission extends StatelessWidget {
  final ProtectedFeature feature;
  final Widget child;
  final Widget? otherwise;

  const CreatingPermission({
    super.key,
    required this.feature,
    required this.child,
    this.otherwise,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    if (user.permissions[feature.name]?.create ?? false) {
      return child;
    }
    return otherwise ?? Container();
  }
}
