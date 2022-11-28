import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selfe_radar/ui/componants/toast/toast.dart';
import '../../Services/local_notification_services/local_notification_services.dart';
import '../../data/firecase/firebase_reposatory.dart';
import '../../utils/conestant/conestant.dart';
import 'mapStates.dart';

class MapCubit extends Cubit<MapState> {

  MapCubit() : super(InitialMapState()){
    services = LocalNotificationServices();
    services.initialize();
  }

  late final LocalNotificationServices services;

  static MapCubit get(context) => BlocProvider.of(context);

  LatLng lat = const LatLng(0, 0);

  double speedMps = 0;

  double preSpeed = 0;

  bool locationButtonFlag = false;

  Completer<GoogleMapController> controller = Completer();

  Color speedColor = Colors.white;

  Color textSpeedColor = Colors.black;

  Location location = Location();

  Set<Marker> markers = {}; //markers for google map

  FirebaseReposatory firebaseRepo = FirebaseReposatory();


  void changeLocation(LatLng lat, double speed) {
    this.lat = lat;
    speedMps = speed;
    animateCamera();
    // emit(ChangeLocationMapState());
  }

  void changeLocationButtonFlag(bool flag) {
    locationButtonFlag = flag;
    // emit(LocationButtonFlagMapState());
  }

  void addMyMark({
    required LatLng position,
  }
      )async{
    BitmapDescriptor markerBitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
      ),
      "assets/images/car.png",
    );
    markers.add(
        Marker( //add start location marker
          markerId: MarkerId("user ID"),
          position: position, //position of marker
          icon: markerBitmap, //Icon for MarchangeLocationker
        )
    );
  }

  void addMark({
    required LatLng position,
  }
  ){
    markers.add(
        Marker( //add start location marker
          markerId: const MarkerId("user ID"),
          position: position, //Icon for Marker
        )
    );
  }

  void getMyLocation(){
    location.getLocation().then((value) {
      changeLocation(LatLng(value.latitude!, value.longitude!),value.speed??9);
      firebaseRepo.saveUserLocation(lat:value.latitude??0,lng:value.longitude??0, speed: value.speed??9);
      animateCamera();
      // addMyMark(position: lat);
    });

    // emit(GetMyLocationMapState());
  }

  void getMyLocationUpDate(context) {
    location.onLocationChanged.listen((LocationData currentLocation) {
      changeLocation(LatLng(currentLocation.latitude!, currentLocation.longitude!),currentLocation.speed??0 *3.6);
      firebaseRepo.saveUserLocation(lat:lat.latitude,lng:lat.longitude,speed:currentLocation.speed??0 *3.6);
      // if(speedMps >= preSpeed){
      //     speedColor = Colors.red;
      //     textSpeedColor = Colors.white;
      //     createAlert(context);
      //     sendNotification();
      // }
      emit(GetMyLocationMapState());
    });
  }

  void carSpeed(){
    Geolocator.getPositionStream().
    listen((position) {
      // changeLocation(LatLng(position.latitude, position.longitude),0);
      print(LatLng(position.latitude, position.longitude));
      print(position.speed);
      speedMps = position.speed;
      if(speedMps > 10 ){
        speedColor = Colors.red.shade100.withOpacity(0.5);}
      addMyMark(position: LatLng(position.latitude, position.longitude));
      emit(CarSpeedMapState());
    });
  }

  Future<void> animateCamera() async {
    final GoogleMapController controller = await this.controller.future;
    CameraPosition cameraPosition;
    controller.getZoomLevel().then((value) {
       cameraPosition = CameraPosition(
        target: lat,
        zoom: value,
      );
       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  void sendNotification(){
    emit(LoadingSendNotificationMapState());
    services.showNotification(id: 0,
        title: "Infraction",
        body: """Speed: $speedMps \n price : 100 """).then((value){
      emit(SuccessSendNotificationMapState());
    }).catchError((onError){
      emit(ErrorSendNotificationMapState(onError.toString()));
    });
  }

  void createAlert(BuildContext context){
    emit(LoadingCreateAlertMapState());
    firebaseRepo.createAlert(
      name: "$constName",
      id: '$constUid',
      nationalID: '$constNationalId',
      currentSpeed: speedMps.toStringAsFixed(0),
      preSpeed: "50",
      carNumber: "$constCarNumber",
      time: "",
      price: "100 LE",
    ).then((value) {
      emit(SuccessCreateAlertMapState());
    }).catchError((onError){
    emit(ErrorCreateAlertMapState(onError.toString()));
    });
  }
}
