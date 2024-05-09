part of 'bad_subject_cubit.dart';

enum SubjectViewOption { list, actions }

extension SubjectViewOptionX on SubjectViewOption {
  String get title {
    switch (this) {
      case SubjectViewOption.list:
        return "Danh sách";
      case SubjectViewOption.actions:
        return "Hoạt động";
    }
  }
}
