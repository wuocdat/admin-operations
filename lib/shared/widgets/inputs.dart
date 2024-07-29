import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tctt_mobile/core/theme/colors.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.labelText,
    this.errorText,
    this.onChanged,
    this.isPassword = false,
  });

  final String labelText;
  final String? errorText;
  final bool isPassword;
  final void Function(String)? onChanged;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      onChanged: widget.onChanged,
      obscureText: passwordVisibility,
      decoration: InputDecoration(
        labelText: widget.labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: AppColors.secondaryBackground,
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(
                  () => passwordVisibility = !passwordVisibility,
                ),
                focusNode: FocusNode(skipTraversal: true),
                child: Icon(
                  passwordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  // color: theme.secondaryText,
                  size: 24,
                ),
              )
            : null,
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.onChanged,
    this.leading,
    this.noAutoFocus = false,
    this.hintText,
    this.readOnly = false,
  });

  final Widget? leading;
  final String? hintText;
  final bool noAutoFocus;
  final bool readOnly;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onChanged: onChanged,
      autofocus: !noAutoFocus,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: leading ?? const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      ),
    );
  }
}

enum InputFormat { text, number }

extension InputFormatX on InputFormat {
  List<TextInputFormatter>? get formatter {
    switch (this) {
      case InputFormat.number:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return null;
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case InputFormat.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

class BorderInput extends StatelessWidget {
  const BorderInput({
    super.key,
    bool? autoFocus,
    String? labelText,
    String? hintText,
    int? maxLines,
    int? minLines,
    int? maxLength,
    String? errorText,
    InputFormat? format,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    Widget? prefix,
  })  : _autoFocus = autoFocus,
        _labelText = labelText,
        _hintText = hintText,
        _maxLines = maxLines,
        _minLines = minLines,
        _maxLength = maxLength,
        _errorText = errorText,
        _controller = controller,
        _format = format ?? InputFormat.text,
        _onChanged = onChanged,
        _prefix = prefix;

  final bool? _autoFocus;
  final String? _labelText;
  final String? _hintText;
  final String? _errorText;
  final int? _maxLines;
  final int? _minLines;
  final int? _maxLength;
  final TextEditingController? _controller;
  final InputFormat _format;
  final ValueChanged<String>? _onChanged;
  final Widget? _prefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: _controller,
      autofocus: _autoFocus ?? false,
      obscureText: false,
      keyboardType: _format.keyboardType,
      inputFormatters: _format.formatter,
      onChanged: _onChanged,
      decoration: InputDecoration(
        prefixIcon: _prefix,
        hintText: _hintText,
        labelText: _labelText,
        errorText: _errorText,
        alignLabelWithHint: true,
        hintStyle: theme.textTheme.labelLarge?.copyWith(
          color: Colors.grey[400],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondaryBackground,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        fontFamily: 'Plus Jakarta Sans',
        letterSpacing: 0,
      ),
      minLines: _minLines,
      maxLines: _maxLines,
      maxLength: _maxLength,
      cursorColor: theme.primaryColor,
    );
  }
}

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    this.onChanged,
    this.leading,
    this.hintText,
    this.backgroundColor,
    this.controller,
  });

  final Widget? leading;
  final String? hintText;
  final Color? backgroundColor;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: leading,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    String? labelText,
    String? hintText,
    String? errorText,
    ValueChanged<String>? onChanged,
  })  : _labelText = labelText,
        _hintText = hintText,
        _errorText = errorText,
        _onChanged = onChanged;

  final String? _labelText;
  final String? _hintText;
  final String? _errorText;
  final ValueChanged<String>? _onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      obscureText: true,
      onChanged: _onChanged,
      decoration: InputDecoration(
        hintText: _hintText,
        labelText: _labelText,
        errorText: _errorText,
        alignLabelWithHint: true,
        hintStyle: theme.textTheme.labelLarge?.copyWith(
          color: Colors.grey[400],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondaryBackground,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        fontFamily: 'Plus Jakarta Sans',
        letterSpacing: 0,
      ),
      cursorColor: theme.primaryColor,
    );
  }
}
