import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/cubit/profile/admin/AdminCubit.dart';
import 'package:selfe_radar/cubit/profile/admin/AdminStates.dart';

import '../../../utils/cach_helper/cache_helper.dart';
import '../../componants/alert_function/alert_function.dart';
import '../../componants/default_text/default_text.dart';
import '../../registration/login.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late File imageFile = File('assets/images/Profile Image.png');

  List<Map<String, dynamic>> lsas = [];

  getAllInfra() async {
    lsas = [];
    await FirebaseFirestore.instance
        .collectionGroup('Infraction')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection('Infraction')
            .doc(element.id)
            .collection('Infractions')
            .get()
            .then((value) {
          for (var element2 in value.docs) {
            setState(() {
              lsas.add(element2.data());
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    getAllInfra();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: BlocConsumer<AdminCubit, AdminStates>(
          listener: (BuildContext context, AdminStates state) {},
          builder: (BuildContext context, AdminStates state) {
            AdminCubit AdminCube = AdminCubit.get(context);

            // print(lsas[1].toString());

            return RefreshIndicator(
                onRefresh: () async {
                  getAllInfra();
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: DoubleBackToCloseApp(
                    snackBar: const SnackBar(
                      content: Text('Tap back again to leave'),
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Card(
                                elevation: 5,
                                color: Colors.blue.shade50,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          CircleAvatar(
                                            radius: 70,
                                            backgroundImage:
                                                AssetImage(imageFile.path),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                          ),
                                          defaultText(
                                              // text: AdminCube.Admin!["name"],
                                              text: "Admin",
                                              size: 20),
                                          // carNumber(
                                          //   number:
                                          //       "${AdminCube.Admin!["carNumber"]}",
                                          // ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            AdminCube.logout();
                                            CacheHelper.removeData(
                                                key: "Admin");
                                            CacheHelper.removeData(key: "name");
                                            CacheHelper.removeData(
                                                key: "email");
                                            CacheHelper.removeData(
                                                key: "nationalId");
                                            CacheHelper.removeData(
                                                key: "carNumber");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Login()));
                                          },
                                          icon: const Icon(Icons.logout)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              lsas.isNotEmpty
                                  ? SizedBox(
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              adminAlertCard(
                                                context: context,
                                                time: lsas[index]['time'],
                                                userDocId: lsas[index]['id'],
                                                alertDocId: lsas[index]
                                                    ['docID'],
                                                history: lsas[index]['history'],
                                                currentSpeed: lsas[index]
                                                    ['currentSpeed'],
                                                preSpeed: lsas[index]
                                                    ['preSpeed'],
                                                name: lsas[index]['name'],
                                                carNumber: lsas[index]
                                                    ['carNumber'],
                                                nationalId: lsas[index]
                                                    ['nationalID'],
                                                price: lsas[index]['price'],
                                              ),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 10),
                                          itemCount: lsas.length),
                                    )
                                  : const Center(
                                      child: Text("NO DATA"),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }

  adminAlertCard({
    carNumber,
    name,
    nationalId,
    required currentSpeed,
    required preSpeed,
    required price,
    required time,
    required history,
    required BuildContext context,
    required userDocId,
    required alertDocId,
  }) {
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
            Center(
                child: ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Infraction')
                    .doc(userDocId)
                    .collection('Infractions')
                    .doc(alertDocId)
                    .delete()
                    .then((value) {});
                await getAllInfra();
                setState(() {});
              },
              child: const Text(
                'Delete',
              ),
            )),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final File imgFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery) as File;
    setState(() => imageFile = imgFile);
  }
}
