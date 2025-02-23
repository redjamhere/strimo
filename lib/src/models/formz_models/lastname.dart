import 'package:formz/formz.dart';

enum LastnameValidationError { empty }

class Lastname extends FormzInput<String, LastnameValidationError> {
  const Lastname.pure() : super.pure("");
  const Lastname.dirty([super.value = ""]) : super.dirty();

  @override
  LastnameValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return LastnameValidationError.empty;
    }
  }
}