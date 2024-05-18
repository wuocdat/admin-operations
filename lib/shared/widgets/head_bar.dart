import 'package:flutter/material.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';

class HeadBar<T> extends StatefulWidget {
  const HeadBar({
    super.key,
    required this.label,
    this.searchValue = "",
    this.action,
    this.onPickedOption,
    this.selectedOption,
    this.options,
    this.onSearchChanged,
    this.hideSearchBar = false,
    this.onCloseSearchInput,
  });

  final String label;
  final String searchValue;
  final Widget? action;
  final bool hideSearchBar;
  final ValueChanged<T?>? onPickedOption;
  final T? selectedOption;
  final List<DropdownMenuItem<T>>? options;
  final ValueChanged<String>? onSearchChanged;
  final void Function()? onCloseSearchInput;

  @override
  State<HeadBar<T>> createState() => _HeadBarState<T>();
}

class _HeadBarState<T> extends State<HeadBar<T>> {
  bool isSearchMode = false;

  void onToggleMode() {
    if (isSearchMode && widget.onCloseSearchInput != null) {
      widget.onCloseSearchInput!();
    }

    setState(() {
      isSearchMode = !isSearchMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
        child: isSearchMode
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: SearchInput(onChanged: widget.onSearchChanged)),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: IconButton(
                        onPressed: onToggleMode,
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      DropdownButtonHideUnderline(
                          child: DropdownButton<T>(
                        value: widget.selectedOption,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        padding: const EdgeInsets.all(0),
                        onChanged: widget.onPickedOption,
                        items: widget.options,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      if (!widget.hideSearchBar)
                        IconButton(
                          onPressed: onToggleMode,
                          icon: const Icon(Icons.search),
                        ),
                      widget.action ?? Container()
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
