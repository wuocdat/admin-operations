import 'package:flutter/material.dart';
import 'package:tctt_mobile/widgets/shadow_box.dart';

class Overview extends StatelessWidget {
  const Overview({
    super.key,
    required this.child,
    required this.title,
    required this.subtitle,
  });

  final Widget child;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ShadowBox(
      noPadding: true,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
