import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/unit_manager/view/unit_manager_page.dart';
import 'package:tctt_mobile/member_manager/view/member_manager_page.dart';
import 'package:tctt_mobile/account_setting/view/account_setting_page.dart';

import '../../authentication/bloc/authentication_bloc.dart';


class ReviewPadding extends StatelessWidget {
  const ReviewPadding({
    super.key,
    required String text,
    required VoidCallback? onPressed,
  })  : _text = text,
        _onPressed = onPressed;

  final VoidCallback? _onPressed;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: _onPressed,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _text,
                  style: const TextStyle(
                    fontFamily: 'Urbanest',
                    fontSize: 22,
                    letterSpacing: 0,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
          child: Scaffold(
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
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    ReviewPadding(text: 'Quản lí tài khoản', onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetting()));
                    }),
                    ReviewPadding(text: 'Đơn vị', onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnitManager()));
                    }),
                    ReviewPadding(text: 'Thành viên', onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MemberManager()));
                    }),
                  ],
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    'App Versions',
                    style: TextStyle(
                      fontFamily: 'Urbanest',
                      letterSpacing: 0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                  child: Text(
                    'v0.0.1',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 0, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      elevation: 0,
                      side: const BorderSide(
                        color: AppColors.secondaryBackground,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested());
                    },
                    child: const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Đăng xuất',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                          fontSize: 16,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
