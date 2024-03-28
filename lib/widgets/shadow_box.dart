import 'package:flutter/material.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox({super.key, required this.child, this.noPadding});

  final Widget child;
  final bool? noPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: noPadding ?? false
              ? const EdgeInsets.all(0)
              : const EdgeInsets.all(12),
          child: child,
        ),
      ),
    );
  }
}
