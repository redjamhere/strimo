// описание виджета с кастомными маркерами
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'package:formz/formz.dart';

//utils
import '../models/models.dart';
import '../utils/utils.dart';

//bloc
import 'package:joyvee/src/bloc/bloc.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 0,
  );
  CameraPosition kLake =
      const CameraPosition(target: LatLng(0.0, 0.0), zoom: 0);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreate(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void convertToMarker(List<StreamMarker> streams) async {
    for (StreamMarker sm in streams) {
      _markers.add(Marker(
          markerId: MarkerId(sm.id.toString()),
          position: sm.position!,
          // icon: await JMarker(streamMarker: s, key: Key(s.id.toString())).toBitmapDescriptor()
          icon: await JMarker(streamMarker: sm).toBitmapDescriptor(
              imageSize: const Size(110, 110),
              logicalSize: const Size(110, 110)),
          onTap: () async {
            context.read<LivemapBloc>().add(LivemapMarkerTapped(sm.id!));
            await showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                isScrollControlled: true,
                builder: (BuildContext ctx) => BlocProvider.value(
                  value: context.read<LivemapBloc>(),
                  child: BlocBuilder<LivemapBloc, LivemapState>(
                    builder: (context, state) {
                      print(state.streamInfoLoadingStatus);
                      if (state.streamInfoLoadingStatus.isSubmissionInProgress || state.streamInfoLoadingStatus.isPure) {
                        return const ShimmerLoadingModalSheet(
                          isLoading: true, child: SizedBox.shrink());
                      } else if (state.streamInfoLoadingStatus.isSubmissionSuccess) {
                        return StreamInfoModalSheet(state.streamInfo);
                      } else if (state.streamInfoLoadingStatus.isSubmissionFailure) {
                        return Center(
                          child: Text(state.errorMessage!, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: JoyveeColors.jvRed
                          )),
                        );
                      } else {
                        return Center(
                          child: Text("Anomaly error 👀", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: JoyveeColors.jvRed
                          )),
                        );
                      }
                    },
                  ),
                ));
          }));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    return Center(
        child: BlocListener<LivemapBloc, LivemapState>(
          listenWhen: (previous, current) =>
              previous.mapContentStatus != current.mapContentStatus,
          listener: (context, state) async {
            if (state.mapContentStatus.isSubmissionSuccess) {
              convertToMarker(state.mapContent.streams);
            }
          },
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
            onMapCreated: _onMapCreate,
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            markers: _markers,
          )));
  }
}
