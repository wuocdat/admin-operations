import 'package:flutter/material.dart';

class MediumLabelText extends StatelessWidget {
  final String text;
  final Color? color;

  const MediumLabelText(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
    );
  }
}

class BodySmallText extends StatelessWidget {
  final String text;
  final Color color;

  const BodySmallText(this.text, {super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
          ),
    );
  }
}
