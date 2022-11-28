import 'package:flutter/material.dart';
import 'package:selfe_radar/Services/local_notification_services/local_notification_services.dart';

class hhh extends StatefulWidget {
  const hhh({Key? key}) : super(key: key);

  @override
  State<hhh> createState() => _hhhState();
}

class _hhhState extends State<hhh> {
  late final LocalNotificationServices services;

  @override
  void initState() {
    // TODO: implement initState
    services = LocalNotificationServices();
    services.initialize();
    super.initState();
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
              onPressed: () async{
                  await services.showNotification(id: 0, title: "Alert", body: """
                  Speed: 66
                  price : 100\n
                  
""");
              },
              child: Text("notification"),
            ),
          ),
        ],
      ),
    );
  }
}
