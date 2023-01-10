import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfe_radar/data/firecase/firebase_reposatory.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';
import 'package:status_alert/status_alert.dart';

import '../../../utils/cach_helper/cache_helper.dart';
import '../../payment/payment.dart';
import '../status_alert/status_alert.dart';

Widget alertFunction({
  carNumber = "",
  name = "",
  nationalId = "",
  required docID,
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
                    showAlertDialog(context, price, docID);
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

showAlertDialog(
  BuildContext context,
  String price,
  String docID,
) {
  // set up the buttons
  bool cardFlag = CacheHelper.getData(key: 'cardNumber') == '';

  Widget cancelButton = TextButton(
    child: defaultText(text: "Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: defaultText(text: 'Pay'),
    onPressed: () {
      Navigator.of(context).pop();
      statusCard(
        context: context,
        title: 'Payment Done',
        configurationIcon: const IconConfiguration(
            icon: FontAwesomeIcons.moneyBill, color: Colors.green, size: 50),
      );
      deleteAlertFunction(docID: docID);
    },
  );

  Widget setPaymentButton = TextButton(
    child: defaultText(text: 'Set Payment'),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Payment()));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: defaultText(text: 'Check Out'),
    content: defaultText(text: 'Are you suer to pay $price ?'),
    actions: [
      cancelButton,
      cardFlag ? setPaymentButton : continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void deleteAlertFunction({
  required docID,
}) {
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  firebaseReposatory.deleteAlert(id: constUid, docID: docID);
}
