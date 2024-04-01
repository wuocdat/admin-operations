import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/task/bloc/task_bloc.dart';
import 'package:tctt_mobile/task/view/searchInput.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: Builder(builder: (context) {
        final isSearchMode =
            context.select((TaskBloc bloc) => bloc.state.isSearchMode);
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x33000000),
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                child: isSearchMode
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: SearchInput(
                              onChanged: (String searchValue) {
                                context.read<TaskBloc>().add(
                                      ChangeSearchInputEvent(searchValue),
                                    );
                              },
                            )),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<TaskBloc>()
                                      .add(ToggleSearchModeEvent());
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Giao nhận nhiệm vụ',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              DropdownButtonHideUnderline(
                                child: BlocBuilder<TaskBloc, TaskState>(
                                  buildWhen: (previous, current) =>
                                      previous.mode != current.mode,
                                  builder: (context, state) {
                                    return DropdownButton<TaskOptions>(
                                      value: context.select(
                                          (TaskBloc bloc) => bloc.state.mode),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 16,
                                      padding: const EdgeInsets.all(0),
                                      onChanged: (TaskOptions? value) {
                                        context.read<TaskBloc>().add(
                                            ChangeModeEvent(
                                                mode: value ??
                                                    TaskOptions.receivedTask));
                                      },
                                      items: TaskOptions.values
                                          .map<DropdownMenuItem<TaskOptions>>(
                                              (TaskOptions value) {
                                        return DropdownMenuItem<TaskOptions>(
                                          value: value,
                                          child: Text(value.title),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<TaskBloc>()
                                  .add(ToggleSearchModeEvent());
                            },
                            icon: const Icon(Icons.search),
                          )
                        ],
                      ),
              ),
            ),
            Text(context.select((TaskBloc bloc) => bloc.state.searchValue))
          ],
        );
      }),
    );
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
