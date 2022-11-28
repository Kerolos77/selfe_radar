
import 'package:flutter/material.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';

Widget carNumber({
  required String number,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(
        color: Colors.black,
        width: 1,
      ),
    ),
    child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: defaultText(text:number,size:20),
    ),
  );
}