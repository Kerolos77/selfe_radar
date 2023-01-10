import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';

import '../../utils/cach_helper/cache_helper.dart';
import '../componants/default_text/default_text.dart';
import '../componants/photp_card/photo_card.dart';

class PaperWork extends StatefulWidget {
  const PaperWork({Key? key}) : super(key: key);

  @override
  State<PaperWork> createState() => _PaperWorkState();
}

class _PaperWorkState extends State<PaperWork> {
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFileNationalID = Future.value(null);
  late Future<PickedFile?> pickedFileCarNumber = Future.value(null);
  late Future<PickedFile?> pickedFileDrivingLicense = Future.value(null);
  final FirebaseStorage _storage = FirebaseStorage.instance;

  bool loadNationalID = false;
  bool loadCarNumber = false;
  bool loadDrivingLicense = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: defaultText(text: 'Paper Work', size: 20),
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: SafeArea(
            child: Column(
              children: [
                photoCard(
                    context: context,
                    label: 'please take a National ID Photo',
                    load: loadNationalID,
                    src: CacheHelper.getData(key: 'National ID Image') ?? '',
                    onPress: () {
                      loadNationalID = true;
                      pickedFileNationalID =
                          tackPhoto(pickedFile: pickedFileNationalID);
                      pickedFileNationalID.then((value) {
                        uploadPic(path: value?.path, name: "National ID Image")
                            .then((value) {
                          loadNationalID = false;
                          setState(() {});
                        });
                      });
                    }),
                photoCard(
                    context: context,
                    label: 'please take a Car Number Photo',
                    load: loadCarNumber,
                    src: CacheHelper.getData(key: 'Car Number Image') ?? '',
                    onPress: () {
                      loadCarNumber = true;
                      pickedFileCarNumber =
                          tackPhoto(pickedFile: pickedFileCarNumber);
                      pickedFileCarNumber.then((value) {
                        uploadPic(path: value?.path, name: "Car Number Image")
                            .then((value) {
                          loadCarNumber = false;
                          setState(() {});
                        });
                      });
                    }),
                photoCard(
                    context: context,
                    label: 'please take a Driving License Photo',
                    load: loadDrivingLicense,
                    src:
                        CacheHelper.getData(key: 'Driving License Image') ?? '',
                    onPress: () {
                      loadDrivingLicense = true;
                      pickedFileDrivingLicense =
                          tackPhoto(pickedFile: pickedFileDrivingLicense);
                      pickedFileDrivingLicense.then((value) {
                        uploadPic(
                                path: value?.path,
                                name: "Driving License Image")
                            .then((value) {
                          loadDrivingLicense = false;
                          setState(() {});
                        });
                      });
                    })
              ],
            ),
          ),
        ));
  }

  tackPhoto({required pickedFile}) {
    pickedFile = picker
        .getImage(source: ImageSource.camera)
        .whenComplete(() => {setState(() {})});

    return pickedFile;
  }

  Future<void> uploadPic({
    required path,
    required name,
  }) async {
    File file = File(path);
    Reference reference = _storage.ref().child("users/$constUid/$name");
    UploadTask uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() async {
      var url = await reference.getDownloadURL();
      CacheHelper.putData(key: name, value: url.toString());
    }).catchError((onError) {
      print(onError);
    });
  }
}
