import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/cubit/profile/user/UserCubit.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';

import '../../../utils/cach_helper/cache_helper.dart';
import '../../componants/alert_function/alert_function.dart';
import '../../componants/default_text/default_text.dart';
import '../../payment/payment.dart';
import '../../registration/login.dart';

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
            userCube.user ?? userCube.getUserData();
            userCube.getUserInfractionsData();

            return ConditionalBuilder(
              condition: userCube.user != null,
              builder: (context) => Scaffold(
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
                                          text:
                                              '${CacheHelper.getData(key: 'name')}',
                                          size: 20),
                                      defaultText(
                                          text:
                                              '${CacheHelper.getData(key: 'nationalID')}',
                                          size: 20),
                                      defaultText(
                                          text:
                                              '${CacheHelper.getData(key: 'carNumber')}',
                                          size: 20),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        userCube.logout();
                                        CacheHelper.removeData(key: "user");
                                        CacheHelper.removeData(key: "name");
                                        CacheHelper.removeData(key: "email");
                                        CacheHelper.removeData(
                                            key: "nationalId");
                                        CacheHelper.removeData(
                                            key: "carNumber");
                                        CacheHelper.removeData(
                                            key: "cardNumber");
                                        CacheHelper.removeData(
                                            key: "cardHolder");
                                        CacheHelper.removeData(
                                            key: "cardMonth");
                                        CacheHelper.removeData(key: "cardYear");
                                        CacheHelper.removeData(key: "cardCvv");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      },
                                      icon: const Icon(
                                          FontAwesomeIcons.rightFromBracket)),
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
                                                        const Payment()));
                                          },
                                          icon: const Icon(
                                              FontAwesomeIcons.creditCard)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          userCube.infractionsUserData.isNotEmpty
                              ? SizedBox(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => alert(
                                            history: userCube
                                                .infractionsUserData[index]
                                                .data()['history'],
                                            address: userCube
                                                .infractionsUserData[index]
                                                .data()['address'],
                                            context: context,
                                            currentSpeed: userCube
                                                .infractionsUserData[index]
                                                .data()['currentSpeed'],
                                            preSpeed: userCube
                                                .infractionsUserData[index]
                                                .data()['preSpeed'],
                                            // name: userCube
                                            //     .infractionsUserData![index]
                                            //     .data()['name'],
                                            // carNumber: userCube
                                            //     .infractionsUserData![index]
                                            //     .data()['carNumber'],
                                            // nationalId: userCube
                                            //     .infractionsUserData![index]
                                            //     .data()['nationalID'],
                                            price: userCube
                                                .infractionsUserData[index]
                                                .data()['price'],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      itemCount:
                                          userCube.infractionsUserData.length),
                                )
                              : Center(
                                  child: defaultText(
                                      text: 'No User Infractions Found'),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              fallback: (context) => Container(
                color: Colors.white,
                child: const CircularProgressIndicator(),
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
