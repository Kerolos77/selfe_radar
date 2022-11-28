
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';
import '../../../cubit/profile/user/UserCubit.dart';
import '../../componants/car_number/CarNumber.dart';
import '../../componants/default_text/default_text.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late File imageFile = File('assets/images/Profile Image.png');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
          listener: (BuildContext context, UserStates state) {},
          builder: (BuildContext context, UserStates state) {
            UserCubit userCube = UserCubit.get(context);
              userCube.getUserData();
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: userCube.user != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width ,
                          child: Card(
                            elevation: 5,
                            color: Colors.blue.shade50,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.06,
                                      ),
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage: AssetImage(imageFile.path),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.06,
                                      ),
                                      defaultText(
                                          text: userCube.user!["name"], size: 20),
                                      carNumber(number: userCube.user!["carNumber"]),
                                      // defaultText(
                                      //     text: userCube.user["carNumber"], size: 15),
                                      // Card(
                                      //   elevation: 5,
                                      //   color: Colors.white,
                                      //   clipBehavior: Clip.none,
                                      //   shape: const RoundedRectangleBorder(
                                      //     borderRadius:
                                      //     BorderRadius.all(Radius.circular(25)),
                                      //   ),
                                      //   child: SizedBox(
                                      //     width:
                                      //     MediaQuery.of(context).size.width * 0.25,
                                      //     height:
                                      //     MediaQuery.of(context).size.height * 0.09,
                                      //     child: Image.asset(imageFile.path,
                                      //         fit: BoxFit.fill),
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   child: Center(
                                      //     child: Column(
                                      //       children: [
                                      //         defaultText(
                                      //             text: "", size: 20),
                                      //         defaultText(
                                      //             text: "kerolofaie@gmaie.com",
                                      //             size: 10),
                                      //         defaultText(text: "0123456789", size: 10),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            defaultText(text: 'مرتب شهري', color: Colors.blue),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            defaultText(text: 'نوع المرتب'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            defaultText(text: '8', color: Colors.blue),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            defaultText(text: 'ساعات العمل'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            defaultText(text: '1', color: Colors.blue),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            defaultText(text: 'الاجازات الاسبوعية'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ) : const Center(child: CircularProgressIndicator(),),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> pickImageFromGallery() async {
    final File imgFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery) as File;
    setState(() => imageFile = imgFile);
  }
}
