import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:tctt_mobile/new_task/bloc/new_task_bloc.dart';
import 'package:tctt_mobile/new_task/models/content.dart';
import 'package:tctt_mobile/new_task/models/title.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/contained_button.dart';
import 'package:tctt_mobile/widgets/dopdown.dart';
import 'package:tctt_mobile/widgets/file_picker.dart';
import 'package:tctt_mobile/widgets/inputs.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:units_repository/units_repository.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key, required this.unitId});

  static Route<void> route(String unitId) {
    return MaterialPageRoute<void>(
      builder: (_) => NewTaskPage(unitId: unitId),
    );
  }

  final String unitId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewTaskBloc(
        unitsRepository: RepositoryProvider.of<UnitsRepository>(context),
      )..add(NewTaskStarted(unitId: unitId)),
      child: Scaffold(
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
            'Nhiệm vụ mới',
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
                child: Column(
                  children: [
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      buildWhen: (previous, current) =>
                          previous.title != current.title,
                      builder: (context, state) {
                        return BorderInput(
                          labelText: 'Tiêu đề',
                          // autoFocus: true,
                          onChanged: (value) => context
                              .read<NewTaskBloc>()
                              .add(TitleChanged(value)),
                          errorText: state.title.displayError?.errorMessage,
                          maxLength: 200,
                          // maxLines: 2,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      buildWhen: (previous, current) =>
                          previous.type != current.type,
                      builder: (context, state) {
                        return BorderDropdown(
                          items: TaskType.values
                              .map(
                                (e) => DropdownMenuEntry(
                                  value: e,
                                  label: e.name,
                                ),
                              )
                              .toList(),
                          initialSelection: state.type,
                          onSelected: (type) => context
                              .read<NewTaskBloc>()
                              .add(TypeChanged(type ?? TaskType.report)),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      buildWhen: (previous, current) =>
                          previous.content != current.content,
                      builder: (context, state) {
                        return BorderInput(
                          labelText: 'Nội dung',
                          maxLines: 16,
                          minLines: 6,
                          onChanged: (value) => context
                              .read<NewTaskBloc>()
                              .add(ContentChanged(value)),
                          errorText: state.content.displayError?.errorMessage,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      builder: (context, state) {
                        return BorderContainer(
                          child:
                              state.fetchDataStatus == FetchDataStatus.loading
                                  ? const Loader()
                                  : TreeView(
                                      data: state.childrenUnits.toTreeList(),
                                      showCheckBox: true,
                                      lazy: true,
                                      load: (node) => context
                                          .read<NewTaskBloc>()
                                          .loadTreeNode(node.extra as String),
                                      onCheck: (checked, node) {
                                        context
                                            .read<NewTaskBloc>()
                                            .add(UnitsChanged(
                                              unit: node.extra,
                                              checked: checked,
                                            ));
                                      },
                                    ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      buildWhen: (previous, current) =>
                          previous.files != current.files,
                      builder: (context, state) {
                        return FilePicker(
                          fileNames: state.files,
                          onFilesSelected: (files) {
                            context.read<NewTaskBloc>().add(FilePicked(files));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      buildWhen: (previous, current) =>
                          previous.important != current.important,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () => context
                              .read<NewTaskBloc>()
                              .add(const ImportantToggled()),
                          child: BorderContainer(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 12),
                              child: Row(
                                children: [
                                  state.important
                                      ? Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : const Icon(Icons.star_outline),
                                  const SizedBox(width: 16),
                                  const Text('Đánh dấu quan trọng'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<NewTaskBloc, NewTaskState>(
                      buildWhen: (previous, current) =>
                          previous.isValid != current.isValid,
                      builder: (context, state) => ContainedButton(
                        onPressed: state.isValid
                            ? () {
                                context
                                    .read<NewTaskBloc>()
                                    .add(const NewTaskSubmitted());
                              }
                            : null,
                        text: "Tạo mới",
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on List<Unit> {
  List<TreeNodeData> toTreeList() {
    return map((e) => e.toTreeNodeData()).toList();
  }
}
