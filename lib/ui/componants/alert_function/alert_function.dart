import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';
import 'package:status_alert/status_alert.dart';

import '../status_alert/status_alert.dart';

Widget alert({
  carNumber = "",
  name = "",
  nationalId = "",
  required currentSpeed,
  required preSpeed,
  required price,
  required address,
  required history,
  required BuildContext context,
}) {
  return Card(
    elevation: 15,
    color: Colors.red.shade100,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Center(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SvgPicture.asset(
          //         'assets/images/alert_svg.svg',
          //         width: 50.w,
          //       ),
          //       SizedBox(
          //         height: 5.h,
          //       ),
          //       // Center(
          //       //   child: defaultText(text: 'Alert', color: Colors.red),
          //       // ),
          //     ],
          //   ),
          // ),
          name != "" && carNumber != ""
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    alertUnit(name.toString()),
                    alertUnit(carNumber.toString()),
                  ],
                )
              : const SizedBox(),
          nationalId != ""
              ? alertUnit(nationalId.toString())
              : const SizedBox(),
          alertUnit(history),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              alertUnit("PreSpeed: $preSpeed", size: 16),
              alertUnit("current Speed: $currentSpeed",
                  size: 16, color: Colors.red),
            ],
          ),
          alertUnit("Address: $address", color: Colors.red),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              defaultText(
                text: 'Price: $price',
                size: 15.0.sp,
                color: Colors.green,
              ),
              IconButton(
                  onPressed: () {
                    statusCard(
                      context: context,
                      title: 'Payment Done',
                      configurationIcon: const IconConfiguration(
                          icon: FontAwesomeIcons.moneyBill,
                          color: Colors.green,
                          size: 50),
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.amazonPay,
                    size: 30.0.sp,
                    color: Colors.green,
                  ))
            ],
          ),
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
