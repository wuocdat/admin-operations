import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/features/mail/widgets/received_mail/bloc/received_mail_bloc.dart';
import 'package:tctt_mobile/features/received_mail_detail/view/received_mail_detail_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/msg_item.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';

class ReceivedMail extends StatelessWidget {
  const ReceivedMail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedMailBloc(
          mailRepository: RepositoryProvider.of<MailRepository>(context))
        ..add(const ReceiverFetchedEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ReceivedMailBloc, ReceivedMailState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text("Đã xảy ra lỗi")),
                  );
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: BlocBuilder<ReceivedMailBloc, ReceivedMailState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case FetchDataStatus.initial:
                        return const Loader();
                      default:
                        if (state.status.isLoading && state.mails.isEmpty) {
                          return const Loader();
                        }
                        return RichListView(
                          onRefresh: () async {
                            context
                                .read<ReceivedMailBloc>()
                                .add(const ReceiverResetEvent());
                          },
                          physics: const AlwaysScrollableScrollPhysics(),
                          hasReachedMax: state.hasReachedMax,
                          itemCount: state.mails.length,
                          itemBuilder: (index) {
                            final currentMail = state.mails[index];
                            return MessageItem(
                              name: currentMail.createdBy['name'],
                              title: currentMail.createdBy['unit']?["name"],
                              content: currentMail.content,
                              time: currentMail.createdAt,
                              highlighted: !currentMail.read,
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    ReceivedMailDetailPage.route(
                                        currentMail.id));
                                if (!context.mounted) return;
                                context
                                    .read<ReceivedMailBloc>()
                                    .add(const ReceiverResetEvent());
                              },
                            );
                          },
                          onReachedEnd: () {
                            context
                                .read<ReceivedMailBloc>()
                                .add(const ReceiverFetchedEvent());
                          },
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
