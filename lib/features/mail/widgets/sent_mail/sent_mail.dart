import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/features/mail/widgets/sent_mail/bloc/sent_mail_bloc.dart';
import 'package:tctt_mobile/features/sent_mail_detail/view/sent_mail_detail_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/msg_item.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';

class SentMail extends StatelessWidget {
  const SentMail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SentMailBloc(
          mailRepository: RepositoryProvider.of<MailRepository>(context))
        ..add(const SentMailsFetchedEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SentMailBloc, SentMailState>(
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
                child: BlocBuilder<SentMailBloc, SentMailState>(
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
                                .read<SentMailBloc>()
                                .add(const SentMailsResetEvent());
                          },
                          physics: const AlwaysScrollableScrollPhysics(),
                          hasReachedMax: state.hasReachedMax,
                          itemCount: state.mails.length,
                          itemBuilder: (index) {
                            final currentMail = state.mails[index];
                            return MessageItem(
                              name: currentMail.receivers
                                  .map((item) => item['name'])
                                  .join(', '),
                              title: currentMail.name,
                              content: currentMail.content,
                              time: currentMail.createdAt,
                              onTap: () => Navigator.push(context,
                                  SentMailDetailPage.route(currentMail.id)),
                            );
                          },
                          onReachedEnd: () {
                            context
                                .read<SentMailBloc>()
                                .add(const SentMailsFetchedEvent());
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
