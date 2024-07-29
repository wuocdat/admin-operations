import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 6) return PasswordValidationError.tooShort;
    return null;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String? get errorMessage {
    if (this == PasswordValidationError.empty) {
      return 'Nội dung không được để trống';
    }
    if (this == PasswordValidationError.tooShort) {
      return 'Mật khẩu quá ngắn';
    }
    return null;
  }
}
