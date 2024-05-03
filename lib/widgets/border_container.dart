import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer({
    super.key,
    required this.child,
    this.borderColor = AppColors.secondaryBackground,
    this.borderWidth = 2,
    this.borderRadius = 8,
    this.height,
  });

  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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

class BottomBorderContainer extends StatelessWidget {
  const BottomBorderContainer({
    super.key,
    required this.child,
    this.borderColor = AppColors.secondaryBackground,
    this.borderWidth = 2,
    this.padding,
  });

  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
      child: child,
    );
  }
}

class SelectableContainer extends StatelessWidget {
  const SelectableContainer({
    super.key,
    required this.content,
    required this.isSelected,
    this.onTap,
  });

  final String content;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(content),
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check,
              size: 16,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }
}
