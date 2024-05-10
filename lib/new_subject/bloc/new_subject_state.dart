part of 'new_subject_bloc.dart';

class NewSubjectState extends Equatable {
  const NewSubjectState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Content.pure(),
    this.uid = const Content.pure(),
    this.fbPageType = FbPageType.personalPage,
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Content name;
  final Content uid;
  final FbPageType fbPageType;
  final bool isValid;

  NewSubjectState copyWith({
    Content? name,
    Content? uid,
    FormzSubmissionStatus? status,
    FbPageType? fbPageType,
    bool? isValid,
  }) {
    return NewSubjectState(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      fbPageType: fbPageType ?? this.fbPageType,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, name, fbPageType, status, isValid];
}
