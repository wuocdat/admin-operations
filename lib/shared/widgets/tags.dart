import 'package:flutter/material.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/shared/widgets/label_text.dart';

class SimpleTag extends StatelessWidget {
  final String text;
  final Color color;

  const SimpleTag({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return text.isEmpty
        ? Container()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: BodySmallText(text.capitalize()),
          );
  }
}
