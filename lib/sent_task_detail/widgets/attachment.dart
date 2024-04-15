import 'package:flutter/material.dart';
import 'package:tctt_mobile/shared/utils/file.dart';
import 'package:tctt_mobile/widgets/internet_img_displayer.dart';

const baseUrl = 'http://10.0.2.2:3200/';

const imageExtensions = ['jpg', 'jpeg', 'png'];

class Attachment extends StatelessWidget {
  const Attachment({super.key, required this.filePaths});

  final List<String> filePaths;

  bool _checkFileIsImage(String filePath) =>
      imageExtensions.contains(filePath.split('.').last);

  void _handleDownloadFile(String filePath) {
    // Download file
  }

  void _onFileTapped(String filePath, BuildContext context) {
    if (_checkFileIsImage(filePath)) {
      showDialog(
          context: context,
          builder: (_) => ImageDialog(url: '$baseUrl$filePath'));
    } else {
      _handleDownloadFile(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...filePaths.map(
          (e) => InkWell(
            onTap: () {
              _onFileTapped(e, context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.attach_file,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      FileHelper.getFileNameFromUrl(e),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
