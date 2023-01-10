import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';

import '../../utils/cach_helper/cache_helper.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late PickedFile imageFile = PickedFile('assets/images/Profile Image.png');

  @override
  Widget build(BuildContext context) {
    bool cardFlag = (CacheHelper.getData(key: 'cardNumber') ?? '') == '';
    final buttonStyle = BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      gradient: const LinearGradient(
          colors: [
            Color(0xff98B4E9),
            Color(0xff9C1FFF),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    );
    final cardDecoration = BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFFB775),
              Color(0xffD736FF),
            ]),
        borderRadius: BorderRadius.circular(15));
    return Scaffold(
      appBar: AppBar(
        title: defaultText(text: 'payment', size: 20),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CreditCardInputForm(
            cardHeight: 170,
            showResetButton: true,
            backCardDecoration: cardDecoration,
            frontCardDecoration: cardDecoration,
            nextButtonDecoration: buttonStyle,
            prevButtonDecoration: buttonStyle,
            resetButtonDecoration: buttonStyle,
            cardNumber:
                cardFlag ? '' : '${CacheHelper.getData(key: 'cardNumber')}',
            cardName:
                cardFlag ? '' : '${CacheHelper.getData(key: 'cardHolder')}',
            cardValid: cardFlag
                ? ''
                : '${CacheHelper.getData(key: 'cardMonth')}/${CacheHelper.getData(key: 'cardYear')}',
            cardCVV: cardFlag ? '' : '${CacheHelper.getData(key: 'cardCvv')}',
            onStateChange: (currentState, cardInfo) {
              if (currentState == InputState.DONE) {
                setPayment(
                  cardNumber: cardInfo.getCardNumber(),
                  cardHolder: cardInfo.getCardHolder(),
                  cardMonth: cardInfo.getCardMonth(),
                  cardYear: cardInfo.getCardYear(),
                  cvv: cardInfo.getCvv(),
                );
              }
            },
            intialCardState: cardFlag ? InputState.NUMBER : InputState.DONE,
            initialAutoFocus: false, // optional
          ),
        ),
      ),
    );
  }

  void setPayment({
    required String cardNumber,
    required String cardHolder,
    required String cardMonth,
    required String cardYear,
    required String cvv,
  }) {
    CacheHelper.saveData(key: 'cardNumber', value: cardNumber);
    CacheHelper.saveData(key: 'cardHolder', value: cardHolder);
    CacheHelper.saveData(key: 'cardMonth', value: cardMonth);
    CacheHelper.saveData(key: 'cardYear', value: cardYear);
    CacheHelper.saveData(key: 'cardCvv', value: cvv);
  }
}
