import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay(
      {super.key, required this.child, required this.isLoading});

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
