import 'package:formz/formz.dart';

enum StreamDescriptionValidationError { empty, long }

class StreamDescription extends FormzInput<String, StreamDescriptionValidationError> {
  const StreamDescription.pure() : super.pure("");
  const StreamDescription.dirty([super.value = ""]) : super.dirty();

  @override
  StreamDescriptionValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return StreamDescriptionValidationError.empty;
    } 
    if (value.length > 200) {
      return StreamDescriptionValidationError.long;
    }
    return null;
  }
}