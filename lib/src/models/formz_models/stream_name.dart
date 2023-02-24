import 'package:formz/formz.dart';

enum StreamNameValidationError { empty, long}

class StreamName extends FormzInput<String, StreamNameValidationError> {
  const StreamName.pure() : super.pure("");
  const StreamName.dirty([super.value = ""]) : super.dirty();

  @override
  StreamNameValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return StreamNameValidationError.empty;
    }
    if (value.length > 20) {
      return StreamNameValidationError.long;
    }
    return null;
  }
}