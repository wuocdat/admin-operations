import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.opacity = 0.8,
    this.overlayColor = Colors.black,
  });

  final Widget child;
  final bool isLoading;
  final double opacity;
  final Color overlayColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: overlayColor),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ]
      ],
    );
  }
}
