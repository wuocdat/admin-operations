import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tctt_mobile/features/login/bloc/login_bloc.dart';
import 'package:tctt_mobile/shared/widgets/contained_button.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text("Đăng nhập không thành công")),
            );
        }
      },
      builder: (context, state) {
        return Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _UsernameInput(),
              const Padding(padding: EdgeInsets.all(12)),
              _PasswordInput(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Checkbox(value: true, onChanged: (newValue) {}),
                    const Text('Nhớ mật khẩu?')
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              _LoginButton(),
            ],
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) => Input(
        key: const Key("loginForm_usernameInput_textField"),
        onChanged: (username) =>
            context.read<LoginBloc>().add(LoginUsernameChanged(username)),
        errorText: state.username.displayError != null
            ? 'Tên đăng nhập không hợp lệ'
            : null,
        labelText: "Tên đăng nhập",
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => Input(
        key: const Key("loginForm_passwordInput_textField"),
        onChanged: (password) =>
            context.read<LoginBloc>().add(LoginPasswordChanged(password)),
        labelText: 'password',
        errorText: state.password.displayError != null
            ? 'Mật khẩu không hợp lệ'
            : null,
        isPassword: true,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => ContainedButton(
        loading: state.status.isInProgress,
        text: "Đăng nhập",
        onPressed: state.isValid
            ? () {
                context.read<LoginBloc>().add(const LoginSubmitted());
              }
            : null,
      ),
    );
  }
}
