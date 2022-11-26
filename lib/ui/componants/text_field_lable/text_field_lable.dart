import 'package:flutter/material.dart';

Widget textRegester({
  required String text,
}) {
  return Column(
    children: [
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}