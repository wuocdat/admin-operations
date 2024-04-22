part of 'attachment_cubit.dart';

enum FileDownloadStatus {
  initial,
  noPermission,
  downloading,
  downloaded,
  downloadFailure
}

class AttachmentState extends Equatable {
  const AttachmentState._(
      {this.fileDownloadStatus = FileDownloadStatus.initial,
      this.receivedPerTotal = '',
      this.percentage = 0});

  const AttachmentState.initial()
      : this._(
          fileDownloadStatus: FileDownloadStatus.initial,
        );

  const AttachmentState.noPermission()
      : this._(fileDownloadStatus: FileDownloadStatus.noPermission);

  const AttachmentState.downloading()
      : this._(
          fileDownloadStatus: FileDownloadStatus.downloading,
        );

  const AttachmentState.failure()
      : this._(
          fileDownloadStatus: FileDownloadStatus.downloadFailure,
        );

  final FileDownloadStatus fileDownloadStatus;
  final String receivedPerTotal;
  final double percentage;

  AttachmentState copyWith({
    FileDownloadStatus? fileDownloadStatus,
    String? receivedPerTotal,
    double? percentage,
  }) {
    return AttachmentState._(
      fileDownloadStatus: fileDownloadStatus ?? this.fileDownloadStatus,
      receivedPerTotal: receivedPerTotal ?? this.receivedPerTotal,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  List<Object> get props => [fileDownloadStatus, receivedPerTotal, percentage];
}
