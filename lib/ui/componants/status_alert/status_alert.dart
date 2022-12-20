import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

void statusCard({
  required BuildContext context,
  required String title,
  required IconConfiguration configurationIcon,
}) {
  return StatusAlert.show(
    context,
    duration: const Duration(seconds: 3),
    title: title,
    configuration: configurationIcon,
    backgroundColor: Colors.grey.shade50,
  );
}