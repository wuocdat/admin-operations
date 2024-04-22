import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/received_task_detail/cubit/received_task_detail_cubit.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:tctt_mobile/widgets/attachment/label_text.dart';
import 'package:tctt_mobile/widgets/file_picker.dart';
import 'package:tctt_mobile/widgets/inputs.dart';
import './cubit/report_form_cubit.dart';
import './models/report_times.dart';

class ReportForm extends StatelessWidget {
  const ReportForm({super.key, this.onClosed, required this.taskProgressId});

  final String taskProgressId;
  final void Function()? onClosed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportFormCubit(
          taskRepository: RepositoryProvider.of<TaskRepository>(context)),
      child: BlocListener<ReportFormCubit, ReportFormState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gửi báo cáo thành công'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<ReceivedTaskDetailCubit>().fetchTask();
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gửi báo cáo thất bại'),
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 12),
              child: MediumLabelText('Báo cáo kết quả'),
            ),
            BlocBuilder<ReportFormCubit, ReportFormState>(
              buildWhen: (previous, current) =>
                  previous.content != current.content,
              builder: (context, state) {
                return BorderInput(
                  labelText: "Nội dung báo cáo",
                  minLines: 4,
                  onChanged: (value) =>
                      context.read<ReportFormCubit>().contentChanged(value),
                  errorText: state.content.displayError?.errorMessage,
                );
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<ReportFormCubit, ReportFormState>(
              builder: (context, state) {
                return BorderInput(
                  labelText: "Số lượt",
                  format: InputFormat.number,
                  onChanged: (value) =>
                      context.read<ReportFormCubit>().timesChanged(value),
                  errorText: state.times.displayError?.errorMessage,
                );
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<ReportFormCubit, ReportFormState>(
              buildWhen: (previous, current) => previous.files != current.files,
              builder: (context, state) {
                return FilePicker(
                  fileNames: state.files,
                  fileType: FileType.image,
                  onFilesSelected: (files) {
                    context.read<ReportFormCubit>().filesChanged(files);
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<ReportFormCubit, ReportFormState>(
              buildWhen: (previous, current) =>
                  previous.isValid != current.isValid ||
                  previous.status != current.status,
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (state.isValid && !state.status.isInProgress)
                        ? () {
                            context
                                .read<ReportFormCubit>()
                                .submit(taskProgressId);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(state.status.isInProgress
                        ? 'Đang gửi...'
                        : 'Gửi báo cáo'),
                  ),
                );
              },
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
        ),
      ),
    );
  }
}
