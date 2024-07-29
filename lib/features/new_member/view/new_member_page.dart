import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tctt_mobile/features/new_member/bloc/new_member_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:tctt_mobile/shared/models/password.dart';
import 'package:tctt_mobile/shared/widgets/contained_button.dart';
import 'package:tctt_mobile/shared/widgets/dopdown.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';
import 'package:tctt_mobile/shared/widgets/loading_overlay.dart';
import 'package:user_repository/user_repository.dart';

class NewMemberPage extends StatelessWidget {
  const NewMemberPage({super.key, required this.currentUnitName});

  static Route<void> route(String unitId, String currentUnitName) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => NewMemberBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          unitId: unitId,
        ),
        child: NewMemberPage(currentUnitName: currentUnitName),
      ),
    );
  }

  final String currentUnitName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewMemberBloc, NewMemberState>(
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
                'Thêm thành viên',
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
                        MemberName(),
                        SizedBox(height: 32),
                        MemberUsername(),
                        SizedBox(height: 32),
                        MemberPassword(),
                        SizedBox(height: 32),
                        MemberRepeatPass(),
                        SizedBox(height: 32),
                        RoleTypeSelector(),
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

class MemberName extends StatelessWidget {
  const MemberName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMemberBloc, NewMemberState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return BorderInput(
          labelText: 'Họ và tên',
          hintText: 'Họ và tên',
          // autoFocus: true,
          onChanged: (value) =>
              context.read<NewMemberBloc>().add(MemberNameChangedEvent(value)),
          errorText: state.name.displayError?.errorMessage,
        );
      },
    );
  }
}

class MemberUsername extends StatelessWidget {
  const MemberUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMemberBloc, NewMemberState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return BorderInput(
          labelText: 'Tên đăng nhập',
          hintText: 'Tên đăng nhập',
          // autoFocus: true,
          onChanged: (value) => context
              .read<NewMemberBloc>()
              .add(MemberUserNameChangedEvent(value)),
          errorText: state.username.displayError?.errorMessage,
        );
      },
    );
  }
}

class MemberPassword extends StatelessWidget {
  const MemberPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMemberBloc, NewMemberState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordInput(
          labelText: 'Mật khẩu',
          hintText: 'Mật khẩu',
          // autoFocus: true,
          onChanged: (value) => context
              .read<NewMemberBloc>()
              .add(MemberPasswordChangedEvent(value)),
          errorText: state.password.displayError?.errorMessage,
        );
      },
    );
  }
}

class MemberRepeatPass extends StatelessWidget {
  const MemberRepeatPass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMemberBloc, NewMemberState>(
      buildWhen: (previous, current) =>
          previous.repeatPass != current.repeatPass,
      builder: (context, state) {
        return PasswordInput(
          labelText: 'Xác nhận mật khẩu',
          hintText: 'Xác nhận mật khẩu',
          // autoFocus: true,
          onChanged: (value) => context
              .read<NewMemberBloc>()
              .add(MemberRepeatPassChangedEvent(value)),
          errorText: state.repeatPass.displayError?.errorMessage ??
              (!state.confirmPass ? "Mật khẩu không khớp" : null),
        );
      },
    );
  }
}

class RoleTypeSelector extends StatelessWidget {
  const RoleTypeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMemberBloc, NewMemberState>(
      buildWhen: (previous, current) => previous.role != current.role,
      builder: (context, state) {
        return BorderDropdown(
          labelText: 'Quyền',
          items: ERole.values
              .where((role) => role != ERole.superadmin)
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: e.name,
                ),
              )
              .toList(),
          initialSelection: state.role,
          onSelected: (type) => context
              .read<NewMemberBloc>()
              .add(MemberRoleChangedEvent(type ?? ERole.member)),
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
    return BlocBuilder<NewMemberBloc, NewMemberState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) => ContainedButton(
        onPressed: state.isValid
            ? () {
                context
                    .read<NewMemberBloc>()
                    .add(const NewMemberSubmittedEvent());
              }
            : null,
        text: "Thêm mới",
      ),
    );
  }
}
