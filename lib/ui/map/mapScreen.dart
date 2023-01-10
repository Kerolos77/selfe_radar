import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../cubit/map/mapCubit.dart';
import '../../cubit/map/mapStates.dart';
import '../componants/speed_card/speed_card.dart';
import '../componants/timer_card/timer_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CountdownTimerController controller;
  bool isInfraction = false;
  bool timerFlag = false;

  BitmapDescriptor markIcon = BitmapDescriptor.defaultMarker;
  late Uint8List bytes;

  String imgUrl = "https://www.fluttercampus.com/img/car.png";

  @override
  Widget build(BuildContext context) {
    MapCubit mapCub = MapCubit.get(context);
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    controller = CountdownTimerController(
      endTime: endTime,
      onEnd: () {
        mapCub.createAlert(context);
        mapCub.sendNotification();
        setState(() {
          timerFlag = false;
        });
      },
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BlocConsumer<MapCubit, MapState>(listener: (context, state) {
          print(state);
        }, builder: (context, state) {
          return SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: mapCub.lat,
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapCub.controller.complete(controller);
                    mapCub.getMyLocation();
                    mapCub.getMyLocationUpDate(context);
                  },
                  onCameraMove: (CameraPosition position) {
                    mapCub.changeLocationButtonFlag(false);
                    mapCub.zoomLevel = position.zoom;
                    mapCub.mapBearing = position.bearing;
                  },
                  indoorViewEnabled: true,
                  myLocationEnabled: true,
                  trafficEnabled: true,
                  buildingsEnabled: true,
                  mapToolbarEnabled: true,
                  mapType: MapType.normal,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      speedCard(
                        speedColor: mapCub.speedColor,
                        textSpeedColor: mapCub.textSpeedColor,
                        speedCar: mapCub.speedMps.toStringAsFixed(0),
                        preSpeed: mapCub.preSpeed.toStringAsFixed(0),
                      ),
                    ],
                  ),
                ),
                BlocListener<MapCubit, MapState>(
                  listener: (context, state) {
                    if (state is GetMyLocationMapState) {
                      debugPrint("isInfraction outside if: $isInfraction");
                      if (mapCub.speedMps >= mapCub.preSpeed && !isInfraction) {
                        mapCub.speedColor = Colors.red;
                        mapCub.textSpeedColor = Colors.white;
                        setState(() {
                          isInfraction = true;
                          timerFlag = true;
                        });
                        debugPrint(
                            "isInfraction inside first if: $isInfraction");
                      }
                      if (mapCub.speedMps < mapCub.preSpeed && isInfraction) {
                        mapCub.speedColor = Colors.green;
                        mapCub.textSpeedColor = Colors.black;
                        setState(() {
                          isInfraction = false;
                          timerFlag = false;
                          controller.dispose();
                        });
                        debugPrint(
                            "isInfraction inside second if: $isInfraction");
                      }
                    }
                  },
                  child: const SizedBox.shrink(),
                )
              ],
            ),
          );
        }),
        if (timerFlag)
          timerCard(
            controller: controller,
          )
        else
          const SizedBox(),
      ],
    );
  }
}
