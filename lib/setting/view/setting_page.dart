import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Quản lý tài khoản',
                                  style: TextStyle(
                                    fontFamily: 'Urbanest',
                                    fontSize: 22,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Đơn vị',
                                  style: TextStyle(
                                    fontFamily: 'Urbanest',
                                    fontSize: 22,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Thành viên',
                                  style: TextStyle(
                                    fontFamily: 'Urbanest',
                                    fontSize: 22,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
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
                    onPressed: () {  },
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
