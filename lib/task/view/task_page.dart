import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/new_task/new_task.dart';
import 'package:tctt_mobile/task/bloc/task_bloc.dart';
import 'package:tctt_mobile/task/widgets/received_task/view/receivered_task.dart';
import 'package:tctt_mobile/task/widgets/sent_task/view/sent_task.dart';
import 'package:tctt_mobile/widgets/head_bar.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return Column(
            children: [
              HeadBar<TaskOptions>(
                label: "Giao nhận nhiệm vụ",
                searchValue: state.searchValue,
                selectedOption: state.mode,
                options: TaskOptions.values
                    .map<DropdownMenuItem<TaskOptions>>((TaskOptions value) {
                  return DropdownMenuItem<TaskOptions>(
                    value: value,
                    child: Text(value.title),
                  );
                }).toList(),
                onPickedOption: (TaskOptions? value) {
                  context.read<TaskBloc>().add(
                      ChangeModeEvent(mode: value ?? TaskOptions.receivedTask));
                },
                onSearchChanged: (value) =>
                    context.read<TaskBloc>().add(ChangeSearchInputEvent(value)),
                onCloseSearchInput: () =>
                    context.read<TaskBloc>().add(const InputClosedEvent()),
                action: !state.mode.isReceiverMode
                    ? BlocSelector<AuthenticationBloc, AuthenticationState,
                        String>(
                        selector: (state) {
                          return state.user.unit.id;
                        },
                        builder: (context, unitId) {
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                NewTaskPage.route(unitId),
                              );
                            },
                            icon: const Icon(Icons.add),
                            color: Theme.of(context).primaryColor,
                          );
                        },
                      )
                    : null,
              ),
              Expanded(child: getCorrespondingItem(state.mode)),
            ],
          );
        },
      ),
    );
  }
}

Widget getCorrespondingItem(TaskOptions mode) {
  switch (mode) {
    case TaskOptions.receivedTask:
      return const ReceivedTasks();
    case TaskOptions.sentTask:
      return const SentTasks();
  }
}
