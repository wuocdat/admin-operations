import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/widgets/border_container.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
  })  : _text = text,
        _icon = icon,
        _onPressed = onPressed;

  final VoidCallback? _onPressed;
  final String _text;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 6,
            textStyle: const TextStyle(
                fontSize: 13,
                fontFamily: 'Plus Jakarta Sans',
                letterSpacing: 0,
                fontWeight: FontWeight.bold),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 28),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _icon,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(_text),
            ],
          ),
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: const BackButton(
              color: Colors.black,
            ),
            title: const Text(
              'Quản lí tài khoản',
              style: TextStyle(
                fontFamily: 'Urbanest',
                letterSpacing: 0,
              ),
            ),
          ),
          body: SafeArea(
            top: true,
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
                              BigPadding(text: 'Thông tin cá nhân'),
                              SmallPadding(text: 'Tài khoản: Nguyễn Văn A'),
                              SmallPadding(text: 'Năm sinh: 2000'),
                              SmallPadding(text: 'SDT:'),
                              SmallPadding(text: 'Đơn vị: Ban chỉ đạo 35'),
                              Devider(),
                              CustomButton(text: 'Cập nhật ', icon: Icons.edit_square, onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: BorderContainer(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigPadding(text: 'Bảo mật'),
                                SmallPadding(text: 'Quyền: Quản lý'),
                                Devider(),
                                CustomButton(text: 'Thay đổi mật khẩu', icon: Icons.password_rounded, onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: BorderContainer(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigPadding(text: 'Xác thực 2 lớp'),
                                SmallPadding(text: 'Trạng thái: Đã kích hoạt'),
                                Devider(),
                                CustomButton(text: 'Ngừng kích hoạt', icon: Icons.privacy_tip_outlined, onPressed: () {}),
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
      ),
    );
  }
}
