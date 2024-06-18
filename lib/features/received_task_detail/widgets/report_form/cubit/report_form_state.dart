part of 'report_form_cubit.dart';

class ReportFormState extends Equatable {
  const ReportFormState({
    this.content = const Content.pure(),
    this.times = const ReportTimes.pure(),
    this.files = const [],
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final Content content;
  final ReportTimes times;
  final List<PlatformFile> files;
  final bool isValid;
  final FormzSubmissionStatus status;

  ReportFormState copyWith({
    Content? content,
    ReportTimes? times,
    List<PlatformFile>? files,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ReportFormState(
      content: content ?? this.content,
      times: times ?? this.times,
      files: files ?? this.files,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [content, times, files, isValid, status];
}
