import 'package:flutter/material.dart';

class WrapOptions extends StatelessWidget {
  const WrapOptions({
    super.key,
    required this.builderItem,
    required this.length,
    required this.selectedIndex,
  });

  final int length;
  final int selectedIndex;
  final Widget Function(int) builderItem;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(length, builderItem),
    );
  }
}
