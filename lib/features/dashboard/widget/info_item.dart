import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Text(
                title,
                style: textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
