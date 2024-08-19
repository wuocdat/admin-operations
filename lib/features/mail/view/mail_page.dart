import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/mail/bloc/mail_container_bloc.dart';
import 'package:tctt_mobile/features/mail/widgets/received_mail/received_mail.dart';
import 'package:tctt_mobile/features/mail/widgets/sent_mail/sent_mail.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/has_permission.dart';
import 'package:tctt_mobile/shared/widgets/head_bar.dart';

const sentTaskRoles = [ERole.superadmin, ERole.admin, ERole.mod];

class MailPage extends StatelessWidget {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MailContainerBloc(),
      child: BlocBuilder<MailContainerBloc, MailContainerState>(
        builder: (context, state) {
          return Column(
            children: [
              HasPermission(
                allowedRoles: sentTaskRoles,
                otherwise: Container(),
                child: HeadBar<MailOptions>(
                  label: "Hòm thư đến/đi",
                  searchValue: state.searchValue,
                  selectedOption: state.mode,
                  hideSearchBar: true,
                  options: MailOptions.values
                      .map<DropdownMenuItem<MailOptions>>((MailOptions value) {
                    return DropdownMenuItem<MailOptions>(
                      value: value,
                      child: Text(value.title),
                    );
                  }).toList(),
                  onPickedOption: (MailOptions? value) {
                    context.read<MailContainerBloc>().add(ChangeModeEvent(
                        mode: value ?? MailOptions.receivedMail));
                  },
                  action: !state.mode.isReceiverMode
                      ? BlocSelector<AuthenticationBloc, AuthenticationState,
                          String>(
                          selector: (state) {
                            return state.user.unit.id;
                          },
                          builder: (context, unitId) {
                            return IconButton(
                              // onPressed: () async {
                              //   await Navigator.push(
                              //     context,
                              //     NewTaskPage.route(unitId),
                              //   );
                              //   if (!context.mounted) return;
                              //   context
                              //       .read<TaskBloc>()
                              //       .add(const ReloadIncreasedEvent());
                              // },
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              color: Theme.of(context).primaryColor,
                            );
                          },
                        )
                      : null,
                ),
              ),
              Expanded(child: getCorrespondingItem(state.mode)),
            ],
          );
        },
      ),
    );
  }
}

Widget getCorrespondingItem(MailOptions mode) {
  switch (mode) {
    case MailOptions.receivedMail:
      return const ReceivedMail();
    case MailOptions.sentMail:
      return const SentMail();
  }
}
