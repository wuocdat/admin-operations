import 'package:flutter/material.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';

class ContainedButton extends StatelessWidget {
  const ContainedButton({
    super.key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    bool? loading,
  })  : _text = text,
        _onPressed = onPressed,
        _width = width ?? double.infinity,
        _height = height ?? 48,
        _loading = loading ?? false;

  final VoidCallback? _onPressed;
  final String _text;
  final double? _width;
  final double? _height;
  final bool _loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: ElevatedButton(
        key: const Key("loginForm_continue_RaisedButton"),
        onPressed: _loading ? null : _onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: _loading
            ? const Loader(size: 20, strokeWith: 2, color: Colors.grey)
            : Text(_text),
      ),
    );
  }
}

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
          onPressed: _onPressed,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required String text,
    required VoidCallback? onPressed,
  }) : _onPressed = onPressed;

  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        elevation: 0,
      ),
      onPressed: _onPressed,
      child: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Text(
          'Đăng xuất',
          style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              letterSpacing: 0,
              fontSize: 16,
              color: Colors.white,),
        ),
      ),
    );
  }
}

class ContentButton extends StatelessWidget {
  const ContentButton({
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
            padding: const EdgeInsets.all(16),
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
