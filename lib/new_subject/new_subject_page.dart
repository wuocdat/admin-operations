import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/new_subject/bloc/new_subject_bloc.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:tctt_mobile/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/widgets/contained_button.dart';
import 'package:tctt_mobile/widgets/dopdown.dart';
import 'package:tctt_mobile/widgets/inputs.dart';
import 'package:tctt_mobile/widgets/loading_overlay.dart';

class NewSubjectPage extends StatelessWidget {
  const NewSubjectPage({super.key, required this.unitId});

  static Route<void> route(String unitId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => NewSubjectBloc(
          targetRepository: RepositoryProvider.of<TargetRepository>(context),
        ),
        child: NewSubjectPage(unitId: unitId),
      ),
    );
  }

  final String unitId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewSubjectBloc, NewSubjectState>(
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
                'Thêm đối tượng',
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
                        SubjectName(),
                        SizedBox(height: 16),
                        SubjectUid(),
                        SizedBox(height: 32),
                        FbPageTypeSelector(),
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

class SubjectName extends StatelessWidget {
  const SubjectName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSubjectBloc, NewSubjectState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return BorderInput(
          labelText: 'Tên đối tượng',
          hintText: 'Tên đối tượng',
          // autoFocus: true,
          onChanged: (value) =>
              context.read<NewSubjectBloc>().add(NameChangedEvent(value)),
          errorText: state.name.displayError?.errorMessage,
          maxLength: 200,
        );
      },
    );
  }
}

class FbPageTypeSelector extends StatelessWidget {
  const FbPageTypeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSubjectBloc, NewSubjectState>(
      buildWhen: (previous, current) =>
          previous.fbPageType != current.fbPageType,
      builder: (context, state) {
        return BorderDropdown(
          labelText: 'Dạng trang facebook',
          items: FbPageType.values
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: e.title,
                ),
              )
              .toList(),
          initialSelection: state.fbPageType,
          onSelected: (type) => context
              .read<NewSubjectBloc>()
              .add(FbPageTypeChangedEvent(type ?? FbPageType.personalPage)),
        );
      },
    );
  }
}

class SubjectUid extends StatelessWidget {
  const SubjectUid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSubjectBloc, NewSubjectState>(
      buildWhen: (previous, current) => previous.uid != current.uid,
      builder: (context, state) {
        return BorderInput(
          labelText: 'UID của đối tượng (facebook.com/uid)',
          hintText: 'UID của đối tượng',
          onChanged: (value) =>
              context.read<NewSubjectBloc>().add(UidChangedEvent(value)),
          errorText: state.uid.displayError?.errorMessage,
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
    return BlocBuilder<NewSubjectBloc, NewSubjectState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) => ContainedButton(
        onPressed: state.isValid
            ? () {
                context.read<NewSubjectBloc>().add(const NewSubjectSubmitted());
              }
            : null,
        text: "Thêm mới",
      ),
    );
  }
}
