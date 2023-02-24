import 'package:formz/formz.dart';

enum OtpValidationError { empty, short }

class OtpCode extends FormzInput<String, OtpValidationError> {
  const OtpCode.pure() : super.pure("");
  const OtpCode.dirty([super.value = ""]) : super.dirty();

  @override
  OtpValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return OtpValidationError.empty;
    }
    // if (value.length < 4) {
    //   return OtpValidationError.short;
    // }
    return null;
  }
}