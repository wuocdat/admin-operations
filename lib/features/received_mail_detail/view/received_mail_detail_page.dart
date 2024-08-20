import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/features/received_mail_detail/cubit/received_mail_detail_cubit.dart';
import 'package:tctt_mobile/shared/widgets/attachment/attachment.dart';
import 'package:tctt_mobile/shared/widgets/content_container.dart';

class ReceivedMailDetailPage extends StatelessWidget {
  const ReceivedMailDetailPage({super.key, required this.mailId});

  static Route<bool> route(String mailId) {
    return MaterialPageRoute<bool>(
      builder: (_) => BlocProvider(
        create: (context) => ReceivedMailDetailCubit(
            mailRepository: context.read<MailRepository>(), mailId: mailId)
          ..fetchMail(),
        child: ReceivedMailDetailPage(mailId: mailId),
      ),
    );
  }

  final String mailId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Hòm thư đến',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Urbanist',
                letterSpacing: 0,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child:
                  BlocBuilder<ReceivedMailDetailCubit, ReceivedMailDetailState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ContentContainer(
                        sender: state.mail.createdBy["unit"]["name"],
                        title: state.mail.name,
                        content: state.mail.content,
                        time: state.mail.createdAt,
                        actions: const [],
                      ),
                      if (state.mail.files.isNotEmpty) const Divider(),
                      if (state.mail.files.isNotEmpty)
                        Attachment(filePaths: state.mail.files),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
