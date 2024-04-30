import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/dashboard/widget/info_item.dart';
import 'package:tctt_mobile/widgets/msg_item.dart';
import 'package:tctt_mobile/widgets/shadow_box.dart';

class MailOverview extends StatelessWidget {
  const MailOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ShadowBox(
      noPadding: true,
      child: Column(
        children: [
          // Generated code for this Row Widget...
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hòm Thư',
                        style: textTheme.headlineSmall,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Tổng quan về gửi nhận thư của đơn vị',
                          style: textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.newestMail == null) {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoItem(
                        value: '${state.mail.all}',
                        title: 'Tất cả',
                      ),
                      InfoItem(
                        value: '${state.mail.read}',
                        title: 'Đã đọc',
                      ),
                      InfoItem(
                        value: '${state.mail.unread}',
                        title: 'Chưa đọc',
                      ),
                    ],
                  ),
                );
              }

              return MessageItem(
                name: 'Tin nhắn mới',
                title: state.newestMail!.name,
                time: state.newestMail!.createdAt,
                content: state.newestMail!.content,
              );
            },
          )
        ],
      ),
    );
  }
}
