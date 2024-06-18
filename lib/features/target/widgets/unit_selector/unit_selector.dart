import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:units_repository/units_repository.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({
    super.key,
    required this.currentUnit,
    required this.stepUnitsList,
    required this.subUnitsList,
    required this.onSelectUnit,
  });

  final Unit currentUnit;
  final List<Unit> stepUnitsList;
  final List<Unit> subUnitsList;
  final void Function(Unit) onSelectUnit;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;

    final rootUnit =
        context.select((AuthenticationBloc bloc) => bloc.state.user.unit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Đang chọn: ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: currentUnit.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...stepUnitsList.map((unit) => StepItem(
              isFirstItem: unit.id == rootUnit.id,
              child: Text(unit.name),
            )),
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
            menuChildren: subUnitsList
                .map((unit) => InkWell(
                      onTap: () => onSelectUnit(unit),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text(unit.name),
                      ),
                    ))
                .toList(),
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
