import 'package:flutter/material.dart';
import 'package:tctt_mobile/widgets/attachment/label_text.dart';
import 'package:tctt_mobile/widgets/file_picker.dart';
import 'package:tctt_mobile/widgets/inputs.dart';

class ReportForm extends StatelessWidget {
  const ReportForm({super.key, this.onClosed});

  final void Function()? onClosed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: MediumLabelText('Báo cáo kết quả'),
        ),
        const BorderInput(
          labelText: "Nội dung báo cáo",
          minLines: 4,
        ),
        const SizedBox(height: 12),
        const BorderInput(
          labelText: "Số lượt",
          format: InputFormat.number,
        ),
        const SizedBox(height: 12),
        FilePicker(fileNames: const [], onFilesSelected: (_) {}),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text('Gửi báo cáo'),
          ),
        ),
        if (onClosed != null)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onClosed,
              child: const Text('Thoát'),
            ),
          ),
      ],
    );
  }
}
