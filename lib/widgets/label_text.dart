import 'package:flutter/material.dart';

class MediumLabelText extends StatelessWidget {
  final String text;

  const MediumLabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}



