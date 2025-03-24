import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tctt_mobile/core/services/firebase_service.dart';
import 'package:tctt_mobile/features/unit_manager/view/unit_manager_page.dart';
import 'package:tctt_mobile/features/member_manager/view/member_manager_page.dart';
import 'package:tctt_mobile/features/account_setting/view/account_setting_page.dart';
import 'package:tctt_mobile/shared/widgets/contained_button.dart';
import 'package:tctt_mobile/shared/widgets/label_text.dart';
import 'package:units_repository/units_repository.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SettingPage(),
    );
  }

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isCrashlyticsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    bool enabled = CrashlyticsService.isCrashlyticsEnabled();
    setState(() {
      _isCrashlyticsEnabled = enabled;
    });
  }

  Future<void> _toggleCrashlytics(bool value) async {
    await CrashlyticsService.setCrashlyticsEnabled(value);
    setState(() {
      _isCrashlyticsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appVersion = dotenv.env['APP_VERSION'];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Cài đặt',
            style: TextStyle(
              fontFamily: 'Urbanest',
              letterSpacing: 0,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  BlocSelector<AuthenticationBloc, AuthenticationState, Unit>(
                    selector: (state) {
                      return state.user.unit;
                    },
                    builder: (context, unit) {
                      return ListTile(
                        title: const Text('Thông tin đơn vị'),
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            UnitManagerPage.route(unit.id, unit.type["_id"]),
                          );
                        },
                      );
                    },
                  ),
                  BlocSelector<AuthenticationBloc, AuthenticationState, Unit>(
                    selector: (state) {
                      return state.user.unit;
                    },
                    builder: (context, unit) {
                      return ListTile(
                        title: const Text('Thông tin thành viên'),
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MemberManager.route(unit.id,
                                  "${unit.type["name"]} ${unit.name}"));
                        },
                      );
                    },
                  ),
                ],
              ),
              ListTile(
                title: const Text('Quản lí tài khoản'),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountSetting()));
                },
              ),
              ListTile(
                title: const Text("Báo cáo lỗi"),
                subtitle: const Text(
                    "Cho phép gửi báo cáo lỗi giúp cải thiện ứng dụng"),
                trailing: Switch(
                  value: _isCrashlyticsEnabled,
                  onChanged: _toggleCrashlytics,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: MediumLabelText("© 2025 c3c7"),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                    child: MediumLabelText("v$appVersion"),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 0, 24),
                    child: CustomElevatedButton(
                      text: 'Đăng Xuất',
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested());
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
