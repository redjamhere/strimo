import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PickedPlaceValidationError { empty, cityEmpty, countryEmpty }

class PickedPlace {
  final LatLng? position;
  final String? country;
  final String? city; 

  const PickedPlace({
    required this.position,
    this.city,
    this.country
  });

  const PickedPlace.emptyConstructor({this.position, this.country, this.city});
  /// TODO: написать валидатор
  PickedPlaceValidationError? validator() {
    if (city == null) {
      return PickedPlaceValidationError.cityEmpty;
    } 
    if (country == null) {
      return PickedPlaceValidationError.countryEmpty;
    }
  }
  
  PickedPlace copyWith({
    LatLng? position,
    String? country,
    String? city
  }) => PickedPlace(
    position: position?? this.position,
    country: country?? this.country,
    city: city?? this.city
  );

  @override
  String toString() {
    if (city == null && country == country) {
      return "Pick your location";
    }
    if (city == null) {
      return 'Город не выбран, $country';
    }
    if (country == null) {
      return '$city, страна не выбрана';
    }
    return '$city, $country';
  }
  
  static const empty = PickedPlace.emptyConstructor();
}