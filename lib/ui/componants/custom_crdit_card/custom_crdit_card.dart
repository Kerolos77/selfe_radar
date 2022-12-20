import 'dart:math';

import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCreditCard extends StatefulWidget {
  CustomCreditCard({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.month,
    required this.year,
    required this.context,
    this.bgColor = Colors.blueAccent,
  });

  String cardNumber;
  String cardHolder;
  int month;
  int year;
  Color bgColor;
  BuildContext context;

  @override
  _CustomCreditCardState createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  int randomColor = 0;
  static LinearGradient firstColor = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffFFB775),
        Color(0xffD736FF),
      ]);
  static LinearGradient secondColor = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff98B4E9),
        Color(0xff9C1FFF),
      ]);
  final bgColor = <LinearGradient>[firstColor, secondColor];

  @override
  void initState() {
    var rng = Random().nextInt(2);
    setState(() {
      randomColor = rng;
    });

    super.initState();
  }

  String renderCreditCardNumberUI(String creditCardNumber) {
    final value = creditCardNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}  ");
    return value;
  }

  IconData renderCreditCardIconUI(String creditCardNumber) {
    var type = detectCCType(creditCardNumber);
    print(type);
    if (type == CreditCardType.visa) {
      return FontAwesomeIcons.ccVisa;
    } else if (type == CreditCardType.mastercard) {
      return FontAwesomeIcons.ccMastercard;
    } else if (type == CreditCardType.unknown) {
      return FontAwesomeIcons.solidCreditCard;
    } else {
      return FontAwesomeIcons.solidCreditCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              gradient: bgColor[randomColor],
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            height: size * 0.55,
            width: size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        renderCreditCardIconUI(
                          widget.cardNumber,
                        ),
                        size: size * 0.09,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        renderCreditCardNumberUI(
                          widget.cardNumber.isEmpty
                              ? "0000000000000000"
                              : widget.cardNumber,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size * 0.058,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "CARD HOLDER",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.white70,
                              fontSize: size * 0.029,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.cardHolder.isEmpty
                                ? "Your Name"
                                : widget.cardHolder,
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: size * 0.029,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Expiry Date",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.white70,
                              fontSize: size * 0.029,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${widget.month.toString().isEmpty ? "00" : widget.month}/${widget.year.toString().isEmpty ? "00" : widget.year}",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: size * 0.029,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 12),
          child: Image.asset(
            "assets/images/creditCardStyleTop.png",
            width: size * 0.13,
            height: size * 0.13,
          ),
        ),
      ],
    );
  }
}
