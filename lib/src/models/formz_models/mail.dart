import 'package:formz/formz.dart';
import 'package:joyvee/src/utils/functions.dart';

enum MailValidationError { empty, wrongFormat }

class Mail extends FormzInput<String, MailValidationError> {
  const Mail.pure() : super.pure("");
  const Mail.dirty([super.value = ""]) : super.dirty();

  @override
  MailValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return MailValidationError.empty;
    }
    if (!JoyveeFunctions.validateEmail(value)) {
      return MailValidationError.wrongFormat;
    }
    return null;
  }
}