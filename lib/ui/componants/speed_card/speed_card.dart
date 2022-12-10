import 'package:flutter/material.dart';

import '../default_text/default_text.dart';

Widget speedCard({
  required String speedCar,
  required String preSpeed,
  required Color speedColor,
  required Color textSpeedColor,
}) {
  return Row(
    children: [
      Expanded(
        child: Card(
          elevation: 8,
          color: speedColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
          ),
          child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultText(
                    text: speedCar, size: 30, color: textSpeedColor),
              )),
        ),
      ),
      Expanded(
        child: Card(
          elevation: 8,
          color: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
          ),
          child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    defaultText(text: preSpeed, size: 30, color: Colors.white),
              )),
        ),
      ),
    ],
  );
}
