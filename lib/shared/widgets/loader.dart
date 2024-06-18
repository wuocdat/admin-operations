import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.size = 40,
    this.strokeWith = 4,
    this.color,
  });

  final double size;
  final double strokeWith;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWith,
        color: color,
      ),
    ));
  }
}

class LoaderWithMessage extends StatelessWidget {
  const LoaderWithMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(
            width: 12,
          ),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
