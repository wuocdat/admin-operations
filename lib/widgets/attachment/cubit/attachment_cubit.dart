import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/utils/file.dart';

part 'attachment_state.dart';

class AttachmentCubit extends Cubit<AttachmentState> {
  AttachmentCubit(TaskRepository taskRepository)
      : _taskRepository = taskRepository,
        super(const AttachmentState.initial());

  final TaskRepository _taskRepository;

  Future<void> downloadFile(String url, String filename) async {
    emit(const AttachmentState.downloading());
    try {
      final path = await FileHelper.getFilePath(filename);

      await _taskRepository.downloadFile(url, path,
          (receivedBytes, totalBytes) {
        final receivedInKB = (receivedBytes / 1024).toStringAsFixed(2);
        final totalInKB = (totalBytes / 1024).toStringAsFixed(2);
        final receivedPerTotal = '$receivedInKB KB/$totalInKB KB';
        final percentage = (receivedBytes / totalBytes * 100);
        emit(state.copyWith(
            receivedPerTotal: receivedPerTotal, percentage: percentage));
      });

      emit(state.copyWith(fileDownloadStatus: FileDownloadStatus.downloaded));
    } catch (_) {
      emit(const AttachmentState.failure());
    }
  }
}
