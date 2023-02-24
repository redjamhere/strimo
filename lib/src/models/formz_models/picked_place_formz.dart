import 'package:formz/formz.dart';
import '../picked_place.dart';

enum PickedPlaceValidatorError { empty, cityIsNull, countryIsNull }

class PickedPlaceFormz extends FormzInput<PickedPlace, PickedPlaceValidatorError> {
  const PickedPlaceFormz.pure() : super.pure(PickedPlace.empty);
  const PickedPlaceFormz.dirty([super.value = PickedPlace.empty]) : super.dirty();

  @override
  PickedPlaceValidatorError? validator(PickedPlace? value) {
    if (value == PickedPlace.empty) {
      return PickedPlaceValidatorError.empty;
    }
    if (value!.city == null) {
      return PickedPlaceValidatorError.cityIsNull;
    }
    if (value.country == null) {
      return PickedPlaceValidatorError.countryIsNull;
    }
  }
}