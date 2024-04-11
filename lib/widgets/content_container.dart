import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.title,
    required this.content,
    required this.time,
    required this.actions,
  });

  final String title;
  final String content;
  final String time;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                'https://images.unsplash.com/photo-1611590027211-b954fd027b51?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      time,
                      style: textTheme.labelSmall?.copyWith(
                        fontFamily: 'Plus Jakarta Sans',
                        color: AppColors.labelSmallText,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ...actions
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            content,
            style: textTheme.labelMedium?.copyWith(
              fontFamily: 'Plus Jakarta Sans',
              color: AppColors.labelSmallText,
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
