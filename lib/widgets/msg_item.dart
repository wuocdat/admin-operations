import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.name,
    required this.title,
    required this.content,
    required this.time,
    this.badgeCount,
    this.onTap,
  });

  final String name;
  final String title;
  final String content;
  final String time;
  final int? badgeCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 100,
                child: VerticalDivider(
                  width: 24,
                  thickness: 4,
                  indent: 12,
                  endIndent: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name.toUpperCase(),
                            style: textTheme.bodySmall,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            // color: textTheme.secondaryText,
                            size: 24,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 4, 0),
                              child: Text(
                                'Thời gian:',
                                style: textTheme.labelMedium,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                time,
                                style: textTheme.bodyMedium,
                              ),
                            ),
                            Badge(
                              label: Text('$badgeCount'),
                              isLabelVisible:
                                  badgeCount != null && badgeCount! > 0,
                              backgroundColor: Theme.of(context).primaryColor,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 4, 0, 0),
                                child: Text('Chi tiết',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
