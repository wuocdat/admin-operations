import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';

class BorderDropdown<T> extends StatelessWidget {
  const BorderDropdown(
      {super.key,
      required List<DropdownMenuEntry<T>> items,
      required T initialSelection,
      required String labelText,
      void Function(T?)? onSelected})
      : _dropdownMenuEntries = items,
        _initialSelection = initialSelection,
        _onSelected = onSelected,
        _labelText = labelText;

  final List<DropdownMenuEntry<T>> _dropdownMenuEntries;
  final T _initialSelection;
  final void Function(T?)? _onSelected;
  final String _labelText;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: _initialSelection,
      onSelected: _onSelected,
      hintText: _labelText,
      label: Text(_labelText),
      dropdownMenuEntries: _dropdownMenuEntries,
      expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondaryBackground,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      ),
    );
  }
}
