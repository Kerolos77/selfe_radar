
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MapCubit(),
      child: BlocConsumer<MapCubit, MapState>(
          listener: (context, state) {
              print(state);
          },
          builder: (context, state) {
        MapCubit mapCub = MapCubit.get(context);
        return SafeArea(
          child:
            Stack(
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
                        onPressed: () {
                          },
                        elevation: 8,
                        backgroundColor: mapCub.speedColor,
                        child: Text(
                          mapCub.speedMps.toStringAsFixed(0),
                          style: TextStyle(
                            color: mapCub.speedMps<35 ?Colors.black:Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                        },
                        elevation: 8,
                        backgroundColor:Colors.red,
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
              ],
            ),
            // StreamBuilder(
            //   stream: FirebaseReposatory.firebase.collection("users").get().asStream(),
            //   builder: (context, snapshot) {
            //     return snapshot.hasData ?Stack(
            //   alignment: AlignmentDirectional.bottomEnd,
            //   children:[
            //             GoogleMap(
            //               initialCameraPosition: CameraPosition(
            //                 target: LatLng(snapshot.data!.docs[1].data()["lat"], snapshot.data!.docs[1].data()["lng"]),
            //                 zoom: 19,
            //               ),
            //               onMapCreated: (GoogleMapController controller) {
            //                 mapCub.controller.complete(controller);
            //                 mapCub.getMyLocation();
            //                 mapCub.getMyLocationUpDate();
            //               },GoogleMap
            //               // myLocationEnabled: true,
            //               // myLocationButtonEnabled: true,
            //      //         FloatingActionButton(
            //           onPressed: () {
            //           },
            //           backgroundColor: mapCub.speedColor,
            //           child: Text(
            //             snapshot.data!.docs[1].data()["speed"].toStringAsFixed(0),
            //             style: const TextStyle(
            //               color: Colors.black,
            //               fontSize: 30,
            //             ),
            //           ),          markers:<Marker>{
            //                   for(var i in snapshot.data!.docs)
            //                     Marker(
            //                       markerId: MarkerId("id"),
            //                       position: LatLng(i.data()["lat"], i.data()["lng"]),
            //                       icon:constUid == i.data()["id"] ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue) : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            //                     ),
            //               },
            //               onCameraMove: (CameraPosition position) {
            //                 mapCub.changeLocationButtonFlag(false);
            //               },
            //               buildingsEnabled: true,
            //               mapToolbarEnabled: true,
            //               mapType: MapType.normal,
            //               onTap: (LatLng latLng) {
            //                 print(latLng);
            //                 mapCub.changeLocation(latLng);
            //                 mapCub.changeLocationButtonFlag(false);
            //               },
            //               rotateGesturesEnabled: true,
            //               scrollGesturesEnabled: true,
            //               zoomControlsEnabled: false,
            //             ),
            //             Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         // FloatingActionButton(
            //         //   mini: true,
            //         //   onPressed: () {
            //         //     mapCub.getMyLocation();
            //         //     mapCub.changeLocationButtonFlag(true);
            //         //   },
            //         //   backgroundColor: Colors.blue.shade200.withOpacity(0.5),
            //         //   child: mapCub.locationButtonFlag
            //         //       ? const Icon(
            //         //     Icons.my_location,
            //         //     color: Colors.blue,
            //         //   )
            //         //       : const Icon(
            //         //     Icons.location_searching,
            //         //     color: Colors.black,
            //         //   ),
            //         // ),
            //         FloatingActionButton(
            //           onPressed: () {
            //           },
            //           backgroundColor: mapCub.speedColor,
            //           child: Text(
            //             snapshot.data!.docs[1].data()["speed"].toStringAsFixed(0),
            //             style: const TextStyle(
            //               color: Colors.black,
            //               fontSize: 30,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ) : const Center(child: CircularProgressIndicator()
            //     );
            //   },
            // ),
        );
      }),
    );
  }
}
