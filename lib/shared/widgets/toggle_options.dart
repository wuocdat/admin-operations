import 'package:flutter/material.dart';
import 'package:tctt_mobile/core/theme/colors.dart';

class ToggleOptions extends StatelessWidget {
  const ToggleOptions({
    super.key,
    required this.selectedIndex,
    this.onPressed,
    required this.items,
  });

  final int selectedIndex;
  final void Function(int)? onPressed;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderColor: AppColors.secondaryBackground,
      selectedBorderColor: Theme.of(context).primaryColor,
      borderWidth: 1.5,
      selectedColor: Colors.black,
      color: Colors.black,
      fillColor: Colors.white,
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 100.0,
      ),
      isSelected: items
          .asMap()
          .entries
          .map<bool>((e) => e.key == selectedIndex)
          .toList(),
      children: items,
    );
  }
}
