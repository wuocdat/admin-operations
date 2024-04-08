import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';

class BorderDropdown extends StatelessWidget {
  BorderDropdown(
      {super.key,
      required List<String> items,
      required String initialSelection,
      void Function(String?)? onSelected})
      : _dropdownMenuEntries = items
            .map((item) => DropdownMenuEntry<String>(value: item, label: item))
            .toList(),
        _initialSelection = initialSelection,
        _onSelected = onSelected;

  final List<DropdownMenuEntry<String>> _dropdownMenuEntries;
  final String _initialSelection;
  final void Function(String?)? _onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: _initialSelection,
      onSelected: _onSelected,
      hintText: "Loại nhiệm vụ",
      label: const Text("Loại nhiệm vụ"),
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
