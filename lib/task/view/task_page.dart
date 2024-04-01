import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/task/bloc/task_bloc.dart';
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
                    context.read<TaskBloc>().add(ChangeModeEvent(
                        mode: value ?? TaskOptions.receivedTask));
                  },
                  onSearchChanged: (value) => context
                      .read<TaskBloc>()
                      .add(ChangeSearchInputEvent(value)),
                ),
                Text(context.select((TaskBloc bloc) => bloc.state.searchValue))
              ],
            );
          },
        ));
  }
}

extension on TaskOptions {
  String get title {
    if (this == TaskOptions.receivedTask) {
      return "Nhận nhiệm vụ";
    } else {
      return "Giao nhiệm vụ";
    }
  }
}
