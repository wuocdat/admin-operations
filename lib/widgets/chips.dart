import 'package:flutter/material.dart';

class CloseChip extends StatelessWidget {
  const CloseChip({
    super.key,
    required this.text,
    required this.onClose,
  });

  final String text;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClose,
      child: Container(
        width: 150,
        padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.close,
              size: 16,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
