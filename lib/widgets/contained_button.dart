import 'package:flutter/material.dart';

class ContainedButton extends StatelessWidget {
  const ContainedButton({
    super.key,
    required String text,
    required VoidCallback? onPressed,
  })  : _text = text,
        _onPressed = onPressed;

  final VoidCallback? _onPressed;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        key: const Key("loginForm_continue_RaisedButton"),
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(_text),
      ),
    );
  }
}
