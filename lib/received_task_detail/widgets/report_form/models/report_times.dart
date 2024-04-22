import 'package:formz/formz.dart';

enum ReportTimesValidationError { empty, invalid, negative }

class ReportTimes extends FormzInput<String, ReportTimesValidationError> {
  const ReportTimes.pure() : super.pure('');
  const ReportTimes.dirty([super.value = '']) : super.dirty();

  @override
  ReportTimesValidationError? validator(String value) {
    final intValue = int.tryParse(value);

    if (value.isEmpty) return ReportTimesValidationError.empty;
    if (intValue == null) return ReportTimesValidationError.invalid;
    if (intValue <= 0) return ReportTimesValidationError.negative;
    return null;
  }
}

extension ReportTimesValidationErrorX on ReportTimesValidationError {
  String? get errorMessage {
    switch (this) {
      case ReportTimesValidationError.empty:
        return 'Trường này không được để trống';
      case ReportTimesValidationError.invalid:
        return 'Trường này phải là số';
      case ReportTimesValidationError.negative:
        return 'Trường này phải lớn hơn 0';
      default:
        return null;
    }
  }
}
