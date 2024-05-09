import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/account_setting/bloc/bloc/account_setting_bloc.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/contained_button.dart';

class BigPadding extends StatelessWidget {
  const BigPadding({
    super.key,
    required String text,
  }) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Text(
        _text,
        style: const TextStyle(
          fontFamily: 'Outfit',
          color: Color(0xFF14181B),
          fontSize: 24,
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class SmallPadding extends StatelessWidget {
  const SmallPadding({
    super.key,
    required String text,
  }) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Text(
        _text,
        style: const TextStyle(
          fontFamily: 'Readex Pro',
          color: Color(0xFF57636C),
          fontSize: 14,
          letterSpacing: 0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class Devider extends StatelessWidget {
  const Devider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: AppColors.secondaryBackground,
    );
  }
}

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AccountSetting(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AccountSettingBloc(),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  'Quản lí tài khoản',
                  style: TextStyle(
                    fontFamily: 'Urbanest',
                    letterSpacing: 0,
                  ),
                ),
              ),
              body: Container(
                color: Colors.white,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BorderContainer(
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const BigPadding(text: 'Thông tin cá nhân'),
                                    SmallPadding(
                                        text: 'Tài khoản: ${state.user.name}'),
                                    SmallPadding(
                                        text:
                                            'Ngày tạo: ${state.user.createdAt}'),
                                    const SmallPadding(text: 'SĐT:'),
                                    SmallPadding(
                                        text:
                                            'Đơn vị: ${state.user.unit.name}'),
                                    const Devider(),
                                    CustomButton(
                                        text: 'Cập nhật ',
                                        icon: Icons.edit_square,
                                        onPressed: () {}),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 16, 0, 0),
                            child: BorderContainer(
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const BigPadding(text: 'Bảo mật'),
                                      SmallPadding(
                                          text:
                                              'Quyền: ${state.user.roleE.name}'),
                                      const Devider(),
                                      CustomButton(
                                          text: 'Thay đổi mật khẩu',
                                          icon: Icons.password_rounded,
                                          onPressed: () {}),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 16, 0, 0),
                            child: BorderContainer(
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const BigPadding(text: 'Xác thực 2 lớp'),
                                      SmallPadding(
                                          text:
                                              'Trạng thái: ${state.user.is2FAEnabled ? 'Đã kích hoạt' : 'Chưa kích hoạt'}'),
                                      const Devider(),
                                      CustomButton(
                                          text: 'Ngừng kích hoạt',
                                          icon: Icons.privacy_tip_outlined,
                                          onPressed: () {}),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
