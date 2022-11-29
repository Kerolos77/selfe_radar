
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';
import '../../../cubit/profile/user/UserCubit.dart';
import '../../../utils/cach_helper/cache_helper.dart';
import '../../componants/alert_function/alert_function.dart';
import '../../componants/car_number/CarNumber.dart';
import '../../componants/default_text/default_text.dart';
import '../../registration/login.dart';
import 'edit_user.dart';

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
              userCube.user?? userCube.getUserData();

            return ConditionalBuilder(
              condition: userCube.user != null,
              builder:(context) => Scaffold(
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
                                        height: MediaQuery.of(context).size.width * 0.06,
                                        width: MediaQuery.of(context).size.width,
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
                                      carNumber(number: "${userCube.user!["carNumber"]}",),
                                    ],
                                  ),
                                  IconButton(onPressed: (){
                                    userCube.logout();
                                    CacheHelper.removeData(key: "user");
                                    CacheHelper.removeData(key: "name");
                                    CacheHelper.removeData(key: "email");
                                    CacheHelper.removeData(key: "nationalId");
                                    CacheHelper.removeData(key: "carNumber");
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                                  }, icon: const Icon(Icons.logout)),
                                  Stack(
                                    alignment: AlignmentDirectional.topStart,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                      IconButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(name: userCube.user!["name"], email: userCube.user!["email"], nationalId: userCube.user!["nationalId"], carNumber: userCube.user!["carNumber"],)));
                                      }, icon: const Icon(Icons.edit)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          alert(
                            context: context,
                            currentSpeed: 60,
                            preSpeed: 50,
                            name: "kerolo faie",
                            carNumber: "ب ت ن 121",
                            nationalId: "123456789",
                            price: "100 lE" ,
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          alert(
                            context: context,
                            currentSpeed: 60,
                            preSpeed: 50,
                            name: "kerolo faie",
                            carNumber: "ب ت ن 121",
                            nationalId: "123456789",
                            price: "100 lE" ,
                          ),
                          // ListView.separated(
                          //       itemBuilder: (context, index) =>
                          //           alert(
                          //             context: context,
                          //             currentSpeed: 60,
                          //             preSpeed: 50,
                          //             name: "kerolo faie",
                          //             carNumber: "ب ت ن 121",
                          //             nationalId: "123456789",
                          //             price: "100 lE" ,
                          //           ),
                          //       separatorBuilder: (context, index) => const SizedBox(
                          //         height: 10
                          //       ),
                          //       itemCount: 15),

                        ],
                      ),
                    ),
                  ),
                ),

              ) ,
              fallback: (context) => Container(color: Colors.white,child: const CircularProgressIndicator(),),
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
