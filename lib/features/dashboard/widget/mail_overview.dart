import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/utils/time.dart';
import 'package:tctt_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/features/dashboard/widget/info_item.dart';
import 'package:tctt_mobile/features/dashboard/widget/overview.dart';
import 'package:tctt_mobile/features/received_mail_detail/view/received_mail_detail_page.dart';
import 'package:tctt_mobile/shared/widgets/msg_item.dart';

class MailOverview extends StatelessWidget {
  const MailOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Overview(
      title: 'Hòm thư',
      subtitle: 'Tổng quan về gửi nhận thư của đơn vị',
      child: BlocBuilder<DashboardBloc, DashboardState>(
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
            time: TimeUtils.convertTimeToReadableFormat(
                state.newestMail!.createdAt),
            content: state.newestMail!.content,
            highlighted: true,
            onTap: () async {
              await Navigator.push(
                  context, ReceivedMailDetailPage.route(state.newestMail!.id));
              if (!context.mounted) return;
              context.read<DashboardBloc>().add(const OverallsReloaded());
            },
          );
        },
      ),
    );
  }
}
