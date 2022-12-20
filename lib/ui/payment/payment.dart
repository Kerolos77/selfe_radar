import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';

import '../componants/custom_crdit_card/custom_crdit_card.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late PickedFile imageFile = PickedFile('assets/images/Profile Image.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defaultText(text: 'payment', size: 20),
        actions: [
          IconButton(
              onPressed: () {
                pickImageFromCamera();
              },
              icon: const Icon(FontAwesomeIcons.edit))
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomCreditCard(
                cardNumber: '4738650008129432',
                cardHolder: 'kerolos faie zaky',
                month: 12,
                year: 2023,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromCamera() async {
    final PickedFile? imgFile =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    debugPrint("**************************${imgFile?.path}");
    setState(() => imageFile = imgFile!);
  }
}
