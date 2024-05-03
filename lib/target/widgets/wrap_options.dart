import 'package:flutter/material.dart';

class WrapOptions extends StatelessWidget {
  const WrapOptions({
    super.key,
    required this.builderItem,
    required this.length,
  });

  final int length;
  final Widget Function(int) builderItem;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: List<Widget>.generate(length, builderItem),
    );
  }
}
