import 'package:formz/formz.dart';
import 'package:joyvee/src/utils/functions.dart';

enum CostValidationError { wrongFormat, longAfterDot }

class Cost extends FormzInput<double, CostValidationError> {
  const Cost.pure() : super.pure(0);
  const Cost.dirty([super.value = 0]) : super.dirty();

  @override
  CostValidationError? validator(double? value) {
    int dc = JoyveeFunctions.decimalCountDigits(value!);
    if (dc > 3) {
      return CostValidationError.longAfterDot;
    }
    return null;
  }
}