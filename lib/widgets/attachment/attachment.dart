import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/widgets/attachment/cubit/attachment_cubit.dart';
import 'package:tctt_mobile/shared/utils/file.dart';
import 'package:tctt_mobile/widgets/label_text.dart';
import 'package:tctt_mobile/widgets/internet_img_displayer.dart';

class Attachment extends StatelessWidget {
  const Attachment({super.key, required this.filePaths, this.withoutTitle});

  final List<String> filePaths;
  final bool? withoutTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttachmentCubit(RepositoryProvider.of<TaskRepository>(context)),
      child: BlocListener<AttachmentCubit, AttachmentState>(
        listenWhen: (previous, current) =>
            previous.fileDownloadStatus != current.fileDownloadStatus,
        listener: (context, state) {
          switch (state.fileDownloadStatus) {
            case FileDownloadStatus.downloading:
              showDialog(
                context: context,
                barrierDismissible:
                    state.fileDownloadStatus == FileDownloadStatus.downloaded,
                builder: (_) =>
                    DownloadProgressDialog(context.read<AttachmentCubit>()),
              );
              break;

            case FileDownloadStatus.downloaded:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Tải xuống thành công'),
                ),
              );
              break;

            case FileDownloadStatus.downloadFailure:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tải xuống thất bại'),
                ),
              );
              break;

            case FileDownloadStatus.noPermission:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Không có quyền truy cập file, cấp quyền trong phần cài đặt'),
                ),
              );
              break;

            default:
              break;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (withoutTitle != true) const MediumLabelText('Tệp đính kèm'),
            const SizedBox(height: 8),
            ...filePaths.map(
              (filePath) => FileItem(
                path: filePath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  const FileItem({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttachmentCubit, AttachmentState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (FileHelper.isImageFile(path)) {
              showDialog(
                context: context,
                builder: (_) => ImageDialog(
                  url: path,
                  onDownload: () => context
                      .read<AttachmentCubit>()
                      .downloadFile(path, FileHelper.getFileNameFromUrl(path)),
                ),
              );
              return;
            }
            context
                .read<AttachmentCubit>()
                .downloadFile(path, FileHelper.getFileNameFromUrl(path));
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
                    FileHelper.getFileNameFromUrl(path),
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
        );
      },
    );
  }
}

class DownloadProgressDialog extends StatelessWidget {
  const DownloadProgressDialog(this.attachmentCubit, {super.key});

  final AttachmentCubit attachmentCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: attachmentCubit,
      child: AlertDialog(
        content: BlocConsumer<AttachmentCubit, AttachmentState>(
          listenWhen: (previous, current) =>
              previous.fileDownloadStatus != current.fileDownloadStatus,
          listener: (context, state) {
            switch (state.fileDownloadStatus) {
              case FileDownloadStatus.downloaded:
                Navigator.of(context).pop();
                break;
              case FileDownloadStatus.downloadFailure:
                Navigator.of(context).pop();
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    "Đang tải xuống...",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                LinearProgressIndicator(
                  value: state.percentage,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                  minHeight: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    state.receivedPerTotal,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
