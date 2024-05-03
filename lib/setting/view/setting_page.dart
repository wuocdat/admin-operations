import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/unit_manager/view/unit_manager_page.dart';
import 'package:tctt_mobile/member_manager/view/member_manager_page.dart';
import 'package:tctt_mobile/account_setting/view/account_setting_page.dart';
import 'package:tctt_mobile/widgets/contained_button.dart';
import 'package:tctt_mobile/widgets/label_text.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SettingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                ContentButton(text: 'Quản lí tài khoản', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSetting()));
                }),
                ContentButton(text: 'Đơn vị', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitManager()));
                }),
                ContentButton(text: 'Thành viên', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MemberManager()));
                }),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: MediumLabelText("App Versions"),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
              child: MediumLabelText("v0.0.1"),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 0, 8),
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
        ),
      )
    );
  }
}
