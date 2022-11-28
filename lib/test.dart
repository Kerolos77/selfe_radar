import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfe_radar/Services/local_notification_services/local_notification_services.dart';
import 'package:selfe_radar/models/alert/alert_model.dart';
import 'package:selfe_radar/utils/ID/CreateId.dart';
import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';

class hhh extends StatefulWidget {
  const hhh({Key? key}) : super(key: key);

  @override
  State<hhh> createState() => _hhhState();
}

class _hhhState extends State<hhh> {
  late final LocalNotificationServices services;
  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    services = LocalNotificationServices();
    services.initialize();
    super.initState();
  }

  // CacheHelper.getData(key: 'user').toString(),

  Future<void> createAlert({
    required String name,
    required String id,
    required String nationalID,
    required String currentSpeed,
    required String preSpeed,
    required String carNumber,
    required String time,
    required String history,
    required String price,
  }) async {
    AlertData alertData = AlertData(name, id, currentSpeed, preSpeed, time,
        history, price, nationalID, "ب ت ع 111");
    return firebase.collection('Infraction').doc(id).collection('Infractions').doc(CreateId.createId()).set(alertData.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await services.showNotification(
                    id: 0,
                    title: "Alert",
                    body:
                        """Speed: 66 price : 100 time: ${DateTime.now().toString()}""");
                await createAlert(
                    carNumber: '',
                    name: 'karim',
                    price: 100.toString(),
                    preSpeed: 50.toString(),
                    currentSpeed: 66.toString(),
                    id: CacheHelper.getData(key: 'user').toString(),
                    nationalID: '12347969540',
                    time: DateFormat("hh:mm a").format(DateTime.now()).toString(),
                    history: DateFormat('MM/dd/yyyy').format(DateTime.now()).toString());
              },
              child: Text("notification"),
            ),
          ),
        ],
      ),
    );
  }
}
