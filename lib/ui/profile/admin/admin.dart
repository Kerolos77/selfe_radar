import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:selfe_radar/cubit/profile/admin/AdminCubit.dart';
import 'package:selfe_radar/cubit/profile/admin/AdminStates.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';
import '../../../utils/cach_helper/cache_helper.dart';
import '../../componants/alert_function/alert_function.dart';
import '../../componants/default_text/default_text.dart';
import '../../registration/login.dart';
import 'edit_admin.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late File imageFile = File('assets/images/Profile Image.png');

  List<Map<String, dynamic>> lsas = [];

  getAllInfra() async {
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

            return RefreshIndicator(
              onRefresh: () async{
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
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
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
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage:
                                            AssetImage(imageFile.path),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
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
                                        CacheHelper.removeData(key: "Admin");
                                        CacheHelper.removeData(key: "name");
                                        CacheHelper.removeData(key: "email");
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
                                  Stack(
                                    alignment: AlignmentDirectional.topStart,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditAdmin(
                                                          name: AdminCube
                                                              .Admin!["name"],
                                                          email: AdminCube
                                                              .Admin!["email"],
                                                          nationalId:
                                                              AdminCube.Admin![
                                                                  "nationalId"],
                                                          carNumber:
                                                              AdminCube.Admin![
                                                                  "carNumber"],
                                                        )));
                                          },
                                          icon: const Icon(Icons.edit)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          lsas.isNotEmpty
                              ? SizedBox(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => alert(
                                            context: context,
                                            currentSpeed: lsas[index]
                                                ['currentSpeed'],
                                            preSpeed: lsas[index]['preSpeed'],
                                            name: lsas[index]['name'],
                                            carNumber: lsas[index]['carNumber'],
                                            nationalId: lsas[index]
                                                ['nationalID'],
                                            price: lsas[index]['price'],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      itemCount: lsas.length),
                                )
                              : Center(
                                  child: Text("NO DATA"),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            // return ConditionalBuilder(
            //   condition: true,
            //   builder: (context) => RefreshIndicator(
            //     onRefresh: () async {
            //       print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            //       print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            //       print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            //       print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            //     },
            //     child: Scaffold(
            //       backgroundColor: Colors.white,
            //       body: SafeArea(
            //         child: SingleChildScrollView(
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 8, right: 8),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.end,
            //               children: [
            //                 Card(
            //                   elevation: 5,
            //                   color: Colors.blue.shade50,
            //                   child: Padding(
            //                     padding: const EdgeInsets.only(bottom: 5.0),
            //                     child: Stack(
            //                       alignment: AlignmentDirectional.topEnd,
            //                       children: [
            //                         Column(
            //                           children: [
            //                             SizedBox(
            //                               height: MediaQuery.of(context)
            //                                       .size
            //                                       .width *
            //                                   0.06,
            //                               width:
            //                                   MediaQuery.of(context).size.width,
            //                             ),
            //                             CircleAvatar(
            //                               radius: 70,
            //                               backgroundImage:
            //                                   AssetImage(imageFile.path),
            //                             ),
            //                             SizedBox(
            //                               height: MediaQuery.of(context)
            //                                       .size
            //                                       .width *
            //                                   0.06,
            //                             ),
            //                             defaultText(
            //                                 // text: AdminCube.Admin!["name"],
            //                                 text: "Admin",
            //                                 size: 20),
            //                             // carNumber(
            //                             //   number:
            //                             //       "${AdminCube.Admin!["carNumber"]}",
            //                             // ),
            //                           ],
            //                         ),
            //                         IconButton(
            //                             onPressed: () {
            //                               AdminCube.logout();
            //                               CacheHelper.removeData(key: "Admin");
            //                               CacheHelper.removeData(key: "name");
            //                               CacheHelper.removeData(key: "email");
            //                               CacheHelper.removeData(
            //                                   key: "nationalId");
            //                               CacheHelper.removeData(
            //                                   key: "carNumber");
            //                               Navigator.push(
            //                                   context,
            //                                   MaterialPageRoute(
            //                                       builder: (context) =>
            //                                           const Login()));
            //                             },
            //                             icon: const Icon(Icons.logout)),
            //                         Stack(
            //                           alignment: AlignmentDirectional.topStart,
            //                           children: [
            //                             SizedBox(
            //                               width:
            //                                   MediaQuery.of(context).size.width,
            //                             ),
            //                             IconButton(
            //                                 onPressed: () {
            //                                   Navigator.push(
            //                                       context,
            //                                       MaterialPageRoute(
            //                                           builder: (context) =>
            //                                               EditAdmin(
            //                                                 name: AdminCube
            //                                                     .Admin!["name"],
            //                                                 email: AdminCube
            //                                                         .Admin![
            //                                                     "email"],
            //                                                 nationalId: AdminCube
            //                                                         .Admin![
            //                                                     "nationalId"],
            //                                                 carNumber: AdminCube
            //                                                         .Admin![
            //                                                     "carNumber"],
            //                                               )));
            //                                 },
            //                                 icon: const Icon(Icons.edit)),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: MediaQuery.of(context).size.height * 0.01,
            //                 ),
            //                 lsas.isNotEmpty
            //                     ? SizedBox(
            //                         child: ListView.separated(
            //                             shrinkWrap: true,
            //                             physics:
            //                                 const NeverScrollableScrollPhysics(),
            //                             itemBuilder: (context, index) => alert(
            //                                   context: context,
            //                                   currentSpeed: lsas[index]
            //                                       ['currentSpeed'],
            //                                   preSpeed: lsas[index]['preSpeed'],
            //                                   name: lsas[index]['name'],
            //                                   carNumber: lsas[index]
            //                                       ['carNumber'],
            //                                   nationalId: lsas[index]
            //                                       ['nationalID'],
            //                                   price: lsas[index]['price'],
            //                                 ),
            //                             separatorBuilder: (context, index) =>
            //                                 const SizedBox(height: 10),
            //                             itemCount: lsas.length),
            //                       )
            //                     : Center(
            //                         child: Text("NO DATA"),
            //                       ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            //   fallback: (context) => Container(
            //     color: Colors.white,
            //     child: const CircularProgressIndicator(),
            //   ),
            // );
          }),
    );
  }

  Widget userCard({
    name,
    nationalId,
    required BuildContext context,
  }) {
    return Card(
      elevation: 15,
      color: Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            alertUnit(name.toString()),
            alertUnit(nationalId.toString()),
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