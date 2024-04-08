import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer({
    super.key,
    required this.child,
    this.borderColor = AppColors.secondaryBackground,
    this.borderWidth = 2,
    this.borderRadius = 8,
  });

  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
