import 'package:formz/formz.dart';

enum TitleValidationError { empty, tooLong }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.pure() : super.pure('');
  const Title.dirty([super.value = '']) : super.dirty();

  @override
  TitleValidationError? validator(String value) {
    if (value.isEmpty) return TitleValidationError.empty;
    if (value.length > 200) return TitleValidationError.tooLong;
    return null;
  }
}

extension TitleValidationX on TitleValidationError {
  String? get errorMessage {
    if (this == TitleValidationError.empty) {
      return 'Không được để trống';
    }
    if (this == TitleValidationError.tooLong) {
      return 'Quá dài';
    }
    return null;
  }
}
