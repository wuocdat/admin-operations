import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:user_repository/user_repository.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Đang chọn: ',
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                text: 'BCD 35',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        BlocSelector<AuthenticationBloc, AuthenticationState, User>(
          selector: (state) {
            return state.user;
          },
          builder: (context, user) {
            return StepItem(
              isFirstItem: true,
              child: Text(user.unit.name),
            );
          },
        ),
        StepItem(
          child: MenuAnchor(
            builder: (context, controller, child) => InkWell(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    'Chọn đơn vị dưới',
                    style: TextStyle(
                        color: themeColor, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    size: 16,
                    color: themeColor,
                  )
                ],
              ),
            ),
            menuChildren: const [],
          ),
        ),
      ],
    );
  }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.child,
    this.isFirstItem = false,
  });

  final Widget child;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirstItem)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: 30,
              width: 2,
              color: AppColors.primary,
            ),
          ),
        Row(
          children: [
            const Icon(Icons.circle, size: 12, color: AppColors.primary),
            const SizedBox(width: 8),
            child,
          ],
        ),
      ],
    );
  }
}
