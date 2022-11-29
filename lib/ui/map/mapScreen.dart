import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Services/local_notification_services/local_notification_services.dart';
import '../../cubit/map/mapCubit.dart';
import '../../cubit/map/mapStates.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isInfraction = false;

  @override
  Widget build(BuildContext context) {
    MapCubit mapCub = MapCubit.get(context);
    return BlocConsumer<MapCubit, MapState>
      (listener: (context, state) {
      print(state);
    }, builder: (context, state) {
      return SafeArea(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapCub.lat,
                zoom: 19,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapCub.controller.complete(controller);
                mapCub.getMyLocation();
                mapCub.getMyLocationUpDate(context);
              },
              onCameraMove: (CameraPosition position) {
                mapCub.changeLocationButtonFlag(false);
                mapCub.zoomLevel = position.zoom;
              },
              onTap: (LatLng latLng) {
                print(latLng);
                // mapCub.changeLocation(latLng);
                mapCub.changeLocationButtonFlag(false);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    elevation: 8,
                    backgroundColor: mapCub.speedColor,
                    child: Text(
                      mapCub.speedMps.toStringAsFixed(0),
                      style: TextStyle(
                        color:
                            mapCub.speedMps < mapCub.preSpeed ? Colors.black : Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    elevation: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      mapCub.preSpeed.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocListener<MapCubit, MapState>(
              listener: (context, state) {
                if (state is GetMyLocationMapState) {
                  debugPrint("isInfraction outside if: $isInfraction");
                  if (mapCub.speedMps > mapCub.preSpeed && !isInfraction) {
                    mapCub.speedColor = Colors.red;
                    mapCub.textSpeedColor = Colors.white;
                    setState(() {
                      isInfraction = true;
                    });
                    mapCub.createAlert(context);
                    mapCub.sendNotification();
                    debugPrint("isInfraction inside first if: $isInfraction");
                  }
                  if (mapCub.speedMps < mapCub.preSpeed && isInfraction) {
                    mapCub.speedColor = Colors.white;
                    mapCub.textSpeedColor = Colors.black;
                    setState(() {
                      isInfraction = false;
                    });
                    debugPrint("isInfraction inside second if: $isInfraction");
                  }
                }
              },
              child: const SizedBox.shrink(),
            )
          ],
        ),
      );
    });
  }
}
