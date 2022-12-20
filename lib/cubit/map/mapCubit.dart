import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../Services/local_notification_services/local_notification_services.dart';
import '../../data/firecase/firebase_reposatory.dart';
import '../../utils/conestant/conestant.dart';
import 'mapStates.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(InitialMapState()) {
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

  Color speedColor = Colors.green;

  Color textSpeedColor = Colors.black;

  Location location = Location();

  var zoomLevel = 17.0;
  var mapBearing = 0.0;

  GeoCode geoCode = GeoCode();

  String address = 'No Address Found';

  int streetNumber = 0;

  FirebaseReposatory firebaseRepo = FirebaseReposatory();

  void changeLocation(LatLng lat, double speed) {
    this.lat = lat;
    speedMps = speed;
    animateCamera();
  }

  void changeLocationButtonFlag(bool flag) {
    locationButtonFlag = flag;
  }

  void getMyLocation() {
    location.getLocation().then((value) {
      changeLocation(LatLng(value.latitude!, value.longitude!), 0);
      firebaseRepo.saveUserLocation(
          lat: value.latitude ?? 0, lng: value.longitude ?? 0, speed: 0);
      animateCamera();
    });
  }

  void getMyLocationUpDate(context) {
    location.onLocationChanged.listen((LocationData currentLocation) {
      // mapBearing = bearingBetween(currentLocation.latitude!,
      //     currentLocation.longitude!, lat.latitude, lat.longitude);
      changeLocation(
          LatLng(currentLocation.latitude!, currentLocation.longitude!),
          currentLocation.speed == null
              ? 0
              : ((currentLocation.speed != null &&
                      currentLocation.speed! * (3600 / 1000) > 0)
                  ? currentLocation.speed! * (3600 / 1000)
                  : 0));
      getAddress(
              lat: currentLocation.latitude!, lng: currentLocation.longitude!)
          .then((value) {
        streetNumber = value.streetNumber!;
        address =
            "${value.streetAddress} , ${value.city} , ${value.region} , ${value.countryName}, ${value.postal}";
      }).catchError((e) {
        debugPrint("++++++++++++++++++++++++ ${e.toString()}");
      });
      updatePreSpeedByStreetNumber(streetNumber);
      firebaseRepo.saveUserLocation(
          lat: lat.latitude,
          lng: lat.longitude,
          speed: ((currentLocation.speed != null &&
                  currentLocation.speed! * (3600 / 1000) > 0)
              ? currentLocation.speed! * (3600 / 1000)
              : 0));
      emit(GetMyLocationMapState());
    });
  }

  Future<void> animateCamera() async {
    final GoogleMapController controller = await this.controller.future;
    CameraPosition cameraPosition;
    cameraPosition = CameraPosition(
      target: lat,
      zoom: zoomLevel,
      bearing: mapBearing,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void sendNotification() {
    emit(LoadingSendNotificationMapState());
    services.showNotification(
        id: 0,
        title: "Infraction",
        body:
            """Speed: ${speedMps.toStringAsFixed(0)} \n price : 100 """).then(
        (value) {
      emit(SuccessSendNotificationMapState());
    }).catchError((onError) {
      emit(ErrorSendNotificationMapState(onError.toString()));
    });
  }

  void createAlert(BuildContext context) {
    emit(LoadingCreateAlertMapState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(constUid)
        .get()
        .then((value) {
      firebaseRepo
          .createAlert(
        name: "${value.data()!['name']}",
        id: '$constUid',
        nationalID: '${value.data()!['nationalID']}',
        currentSpeed: speedMps.toStringAsFixed(0),
        preSpeed: preSpeed.toStringAsFixed(0),
        carNumber: "${value.data()!['carNumber']}",
        price: "100 LE",
        address: address,
      )
          .then((value) {
        emit(SuccessCreateAlertMapState());
      }).catchError((onError) {
        emit(ErrorCreateAlertMapState(onError.toString()));
      });
    });
  }

  Future<Address> getAddress({
    required double lat,
    required double lng,
  }) {
    return geoCode.reverseGeocoding(latitude: lat, longitude: lng);
  }

  void updatePreSpeedByStreetNumber(int streetNumber) {
    switch (streetNumber) {
      case 15:
        preSpeed = 100;
        break;
      case 0:
        preSpeed = 50;
    }
  }

  static double bearingBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) =>
      GeolocatorPlatform.instance.bearingBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );
// static double bearing() =>
//     GeolocatorPlatform.instance.b
}
