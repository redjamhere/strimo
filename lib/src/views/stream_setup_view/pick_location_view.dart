import 'dart:async';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:joyvee/src/cubit/cubit.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/services/services.dart';
import 'package:joyvee/src/utils/config.dart';
import 'place_search_view.dart';
import 'package:joyvee/src/widgets/buttons.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:google_geocoding/google_geocoding.dart' as geo;
import 'package:joyvee/src/widgets/text_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickLocationView extends StatelessWidget {
  PickLocationView({Key? key}) : super(key: key);

  GlobalKey<AutoCompleteTextFieldState<String>> autoCompleteKey = GlobalKey<AutoCompleteTextFieldState<String>>();

  bool _buttonEnabled =  false;

  geo.GoogleGeocoding? googleGeocoding;
  late LatLng _currentPosition;

  final Completer<GoogleMapController> _mapController = Completer();

  final MapService _api = MapService();

  final Set<Marker> markers = Set();


  final TextEditingController _searchController = TextEditingController();

  Future moveCameraToPlace(LatLng target) async {
    GoogleMapController c = await _mapController.future;
    await c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      zoom: 14,
      target: LatLng(
        target.latitude,
        target.longitude
      ))));
  }

  void _onMapCreate(GoogleMapController controller) async {
    Position pos = await _api.determinePosition();
    // setState(() {
    //   _currentPosition = LatLng(pos.latitude, pos.longitude);
    // });
    _mapController.complete(controller);
  }

  Future _handlePickLocation() async {
    await moveCameraToPlace(_currentPosition);
    geo.GeocodingResponse? res = await googleGeocoding!.geocoding.getReverse(geo.LatLon(_currentPosition.latitude, _currentPosition.longitude));
    if (res != null) {
      var components = res.results![0].addressComponents;
      PickedPlace place = PickedPlace(
        position: _currentPosition,
      );
      for (var a in components!) {
        if (a.types!.first == 'country') {
          place = place.copyWith(
            country: a.longName
          );
        }
        if (a.types!.first == 'locality') {
          place = place.copyWith(
            city: a.longName
          );
        }
      }
      // ignore: use_build_context_synchronously
      // context.read<StreamSetupBloc>().add(StreamSetupLocationPicked(place));
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    void _handleSelectPlaceFromPlaceSearch() async {
      LatLng? result = await Navigator.push(context, CupertinoPageRoute(builder: (ctx) => const PlaceSearchView()));
      if (result != null) {
        moveCameraToPlace(result);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Material(
          borderRadius: BorderRadius.circular(12),
          child: JoyveeSearchTextField(
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
            controller: TextEditingController(),
            readOnly: true,
            hintText: "Enter the address",
            onTap: () => _handleSelectPlaceFromPlaceSearch()
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 4
        ),
        child: BlocBuilder<PickLocationCubit, PickLocationState>(
          buildWhen: (previous, current) => previous.pickLocationStatus != current.pickLocationStatus,
          builder: (context, state) {
            return JoyveeElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                elevation: MaterialStateProperty.all<double>(10),
                shadowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return JoyveeColors.jvGreyDisabledButton;
                    }
                    return JoyveeColors.jvOrange;
                  }
                ),
                  // minimumSize: MaterialStateProperty.all<Size>(const Size(60, 60)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
                minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(0))
              ),
              func:
                state.pickLocationStatus.isSubmissionInProgress ? null :
                context.read<PickLocationCubit>().pickLocation,
              child: const Text("Pick place"));
          },
        ),
      ),
      body: BlocConsumer<PickLocationCubit, PickLocationState>(
        listenWhen: (previous, current) => previous.pickLocationStatus != current.pickLocationStatus,
        listener: (context, state) {
          if (state.pickLocationStatus.isSubmissionSuccess) {
            Navigator.pop(context);
          }
          if (state.pickLocationStatus.isSubmissionFailure) {
            JoyveeFlushbars.showErrorFlushbar(
                context,
                title: "Error",
                message: "Location selection error");
          }
        },
        buildWhen: (previous, current) => previous.currentPositionStatus != current.currentPositionStatus,
        builder: (context, state) {
          if (state.currentPositionStatus.isSubmissionInProgress) {
            return const FullScreenProgressIndicator();
          } else {
            return Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(color: JoyveeColors.jvGreySecondary, spreadRadius: 1, blurRadius: 10)]
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                    child: GoogleMap(
                        initialCameraPosition: state.pickedPosition,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        onCameraMove: context.read<PickLocationCubit>().onCameraMove,
                        // onCameraIdle: () => setState(() {
                        //   _buttonEnabled = true;
                        // }),
                        onMapCreated: _onMapCreate),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/png/place_picker_icon.png", height: 50,
                    ),),
                ],
              ),
            );
          }
        }
      ),
    );
  }
}