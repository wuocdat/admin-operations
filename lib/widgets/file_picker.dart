import 'package:file_picker/file_picker.dart' as picker;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/loader.dart';

const int _maxFileSizeInMb = 10 * 1024 * 1024;

class FilePicker extends StatefulWidget {
  const FilePicker({
    super.key,
    required List<picker.PlatformFile> fileNames,
    required this.onFilesSelected,
  }) : _files = fileNames;

  final List<picker.PlatformFile> _files;
  final void Function(List<picker.PlatformFile>) onFilesSelected;

  @override
  State<FilePicker> createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  bool _isLoading = false;

  Future<void> _onTap() async {
    setState(() {
      _isLoading = true;
    });
    picker.FilePickerResult? result =
        await picker.FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _isLoading = false;
      });
      final files = result.files.nonNulls
          .where((element) => element.size <= _maxFileSizeInMb)
          .toList();
      if (files.length > 5) {
        files.removeRange(5, files.length);
      }
      widget.onFilesSelected(result.files.nonNulls
          .where((element) => element.size <= _maxFileSizeInMb)
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: BorderContainer(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: _isLoading
              ? const LoaderWithMessage(message: "Đang mở trình duyệt file...")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.attach_file_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Đính kèm file (kích thước nhỏ hơn 10MB, tối đa 5 file)',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    widget._files.isNotEmpty
                        ? const Divider(
                            color: AppColors.secondaryBackground,
                          )
                        : const SizedBox(),
                    ...widget._files
                        .map((e) => FileItem(fileName: e.name, size: e.size)),
                  ],
                ),
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String fileName;
  final int size;

  const FileItem({
    super.key,
    required this.fileName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
      child: Row(
        children: [
          Icon(
            Icons.file_upload_sharp,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fileName),
              Text(
                '${(size / 1024).toStringAsFixed(2)} KB',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
