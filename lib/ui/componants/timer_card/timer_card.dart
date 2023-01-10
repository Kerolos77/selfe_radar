import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';

Widget timerCard({
  required CountdownTimerController controller,
}) {
  return Card(
    elevation: 8,
    color: Colors.redAccent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: Container(
      height: 60,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CountdownTimer(
          controller: controller,
          widgetBuilder: (_, CurrentRemainingTime? time) {
            if (time == null) {
              return defaultText(text: '0', size: 30);
            }
            return defaultText(text: time.sec.toString(), size: 30);
          },
        ),
      ),
    ),
  );
}
