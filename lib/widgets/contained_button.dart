import 'package:flutter/material.dart';

class ContainedButton extends StatelessWidget {
  const ContainedButton({
    super.key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
  })  : _text = text,
        _onPressed = onPressed,
        _width = width ?? double.infinity,
        _height = height ?? 48;

  final VoidCallback? _onPressed;
  final String _text;
  final double? _width;
  final double? _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: ElevatedButton(
        key: const Key("loginForm_continue_RaisedButton"),
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(_text),
      ),
    );
  }
}
