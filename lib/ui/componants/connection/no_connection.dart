import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../default_text/default_text.dart';

Widget noConnectionCard({
  required Widget child,
}) {
  return OfflineBuilder(
    connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
        ) {
      final bool connected = connectivity != ConnectivityResult.none;
      return connected ? child : noConnection();
    },
    child: child,
  );
}
Widget noConnection() {
  return Container(
    color: Colors.blue.shade50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Image(
            image: AssetImage('assets/images/No connection.png'),
            fit: BoxFit.contain,
            // height: 200,
            // width: 200,
          ),
        ),
        defaultText(text: 'Opps!', size: 20),
        const SizedBox(height: 10),
        defaultText(text: 'Connection Error', size: 16),
      ],
    ),
  );
}