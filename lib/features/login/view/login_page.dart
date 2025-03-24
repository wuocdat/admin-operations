import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/services/firebase_service.dart';
import 'package:tctt_mobile/features/login/bloc/login_bloc.dart';
import 'package:tctt_mobile/features/login/view/login_form.dart';
import 'package:tctt_mobile/shared/widgets/crashlytics_permission_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();
    _checkAndShowCrashlyticsDialog();
  }

  Future<void> _checkAndShowCrashlyticsDialog() async {
    final hasAsked = await storage.read(key: "hasAskedCrashlytics");

    if (hasAsked == null && mounted) {
      showDialog(
        context: context,
        builder: (context) => const CrashlyticsPermissionDialog(),
      );
      await storage.write(key: "hasAskedCrashlytics", value:  'true');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: BlocProvider(
            create: (context) => LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 140,
                      child: Center(
                        child: Text(
                          "MTTN",
                          style: theme.textTheme.displayMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text(
                      "Đăng nhập",
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    const Text("Hệ thống hỗ trợ chỉ đạo điều hành MTTN"),
                    const Padding(padding: EdgeInsets.all(12)),
                    const LoginForm(),
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
