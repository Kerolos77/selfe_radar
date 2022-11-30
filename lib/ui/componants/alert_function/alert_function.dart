import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';

Widget alert({
  carNumber,
  name,
  nationalId,
  required currentSpeed,
  required preSpeed,
  required price,
  required time,
  required history,
  required BuildContext context,
}) {
  // var width = MediaQuery.of(context).size.width;
  // var height = MediaQuery.of(context).size.height;
  return Card(
    elevation: 15,
    color: Colors.red.shade100,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/alert_svg.svg',
                  width: 50.w,
                ),
                SizedBox(
                  height: 5.h,
                ),
                // Center(
                //   child: defaultText(text: 'Alert', color: Colors.red),
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              alertUnit(name.toString()),
              alertUnit(carNumber.toString()),
            ],
          ),

          alertUnit(nationalId.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // alertUnit(DateFormat("hh:mm a").format(DateTime.now())),
              // alertUnit(DateFormat('MM/dd/yyyy').format(DateTime.now())),
              alertUnit(time),
              alertUnit(history),
            ],
          ),

          Row(
            children: [
              alertUnit("PreSpeed: $preSpeed", size: 16),
              const Spacer(),
              alertUnit("current Speed: $currentSpeed",
                  size: 16, color: Colors.red),
            ],
          ),
          Center(child: alertUnit("Price: $price", color: Colors.green)),
        ],
      ),
    ),
  );
}

Widget alertUnit(text, {double size = 15.0, Color? color}) {
  return Column(
    children: [
      SizedBox(
        height: 20.h,
      ),
      defaultText(
        text: text.toString(),
        size: size.sp,
        color: color ?? Colors.black,
      ),
    ],
  );
}
