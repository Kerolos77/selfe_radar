
import 'package:flutter/material.dart';

Widget carNumber({
  required String number,
}) {
  return Card(
    child: Column(
      children: [
        Row(
          children: const [
            Text(
              "مصر",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "EGYPT",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          children:  [
            Text(
              number,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}