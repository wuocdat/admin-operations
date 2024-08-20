import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:formz/formz.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:tctt_mobile/features/new_mail/cubit/new_mail_cubit.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:tctt_mobile/shared/widgets/border_container.dart';
import 'package:tctt_mobile/shared/widgets/contained_button.dart';
import 'package:tctt_mobile/shared/widgets/file_picker.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/loading_overlay.dart';
import 'package:units_repository/units_repository.dart';

class NewMailPage extends StatelessWidget {
  const NewMailPage({super.key, required this.unitId});

  static Route<void> route(String unitId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => NewMailCubit(
          unitRepository: RepositoryProvider.of<UnitsRepository>(context),
          mailRepository: RepositoryProvider.of<MailRepository>(context),
        )..fetchUnitTree(),
        child: NewMailPage(unitId: unitId),
      ),
    );
  }

  final String unitId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewMailCubit, NewMailState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case FormzSubmissionStatus.success:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo mới thành công'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
            break;
          case FormzSubmissionStatus.failure:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo mới thất bại'),
              ),
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.status == FormzSubmissionStatus.inProgress,
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
                'Thư mới',
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
                child: const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        MailTitle(),
                        SizedBox(height: 16),
                        MailContent(),
                        SizedBox(height: 16),
                        UnitTree(),
                        SizedBox(height: 16),
                        FileBrowser(),
                        SizedBox(height: 16),
                        ImportantChecker(),
                        SizedBox(height: 32),
                        SubmitButton(),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MailTitle extends StatelessWidget {
  const MailTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMailCubit, NewMailState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return BorderInput(
          labelText: 'Tiêu đề',
          // autoFocus: true,
          onChanged: (value) => context.read<NewMailCubit>().changeTitle(value),
          errorText: state.title.displayError?.errorMessage,
          maxLength: 200,
        );
      },
    );
  }
}

class MailContent extends StatelessWidget {
  const MailContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMailCubit, NewMailState>(
      buildWhen: (previous, current) => previous.content != current.content,
      builder: (context, state) {
        return BorderInput(
          labelText: 'Nội dung',
          maxLines: 16,
          minLines: 6,
          onChanged: (value) =>
              context.read<NewMailCubit>().changeContent(value),
          errorText: state.content.displayError?.errorMessage,
        );
      },
    );
  }
}

class UnitTree extends StatelessWidget {
  const UnitTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMailCubit, NewMailState>(
      buildWhen: (previous, current) =>
          previous.fetchDataStatus != current.fetchDataStatus ||
          previous.unitNodes != current.unitNodes,
      builder: (context, state) {
        return BorderContainer(
          child: state.fetchDataStatus == FetchDataStatus.loading
              ? const Loader()
              : TreeView(
                  data: state.unitNodes.toTreeList(),
                  showCheckBox: true,
                  lazy: true,
                  load: (node) => context
                      .read<NewMailCubit>()
                      .loadTreeNode(node.extra as String),
                  onCheck: (checked, node) {
                    context.read<NewMailCubit>().changeUnits(
                          node.extra,
                          checked,
                        );
                  },
                ),
        );
      },
    );
  }
}

class FileBrowser extends StatelessWidget {
  const FileBrowser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMailCubit, NewMailState>(
      buildWhen: (previous, current) => previous.files != current.files,
      builder: (context, state) {
        return FilePicker(
          fileNames: state.files,
          onFilesSelected: (files) {
            context.read<NewMailCubit>().pickFile(files);
          },
        );
      },
    );
  }
}

class ImportantChecker extends StatelessWidget {
  const ImportantChecker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMailCubit, NewMailState>(
      buildWhen: (previous, current) => previous.important != current.important,
      builder: (context, state) {
        return InkWell(
          onTap: () => context.read<NewMailCubit>().toggleImportant(),
          child: BorderContainer(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
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
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMailCubit, NewMailState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) => ContainedButton(
        onPressed: state.isValid
            ? () {
                context.read<NewMailCubit>().submitNewMail();
              }
            : null,
        text: "Tạo mới",
      ),
    );
  }
}

extension on List<UnitNode> {
  List<TreeNodeData> toTreeList() {
    return map((e) => e.toTreeNodeData()).toList();
  }
}
