import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/cubit/profile/user/UserCubit.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';
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
            userCube.user ?? userCube.getUserData();

            userCube.getUserInfractionsData();

            // userCube.getUserInfractionsData();

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
                                          text: userCube.user!["name"],
                                          size: 20),
                                      carNumber(
                                        number:
                                            "${userCube.user!["carNumber"]}",
                                      ),
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
                                                        EditUser(
                                                          name: userCube
                                                              .user!["name"],
                                                          email: userCube
                                                              .user!["email"],
                                                          nationalId:
                                                              userCube.user![
                                                                  "nationalId"],
                                                          carNumber:
                                                              userCube.user![
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
                          userCube.infractionsUserData !=null? SizedBox (
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => alert(
                                  time: userCube.infractionsUserData![index].data()['time'],
                                      history: userCube.infractionsUserData![index].data()['history'],
                                      context: context,
                                      currentSpeed: userCube.infractionsUserData![index].data()['currentSpeed'],
                                      preSpeed:userCube.infractionsUserData![index].data()['preSpeed'],
                                      name: userCube.infractionsUserData![index].data()['name'],
                                      carNumber: userCube.infractionsUserData![index].data()['carNumber'],
                                      nationalId: userCube.infractionsUserData![index].data()['nationalID'],
                                      price: userCube.infractionsUserData![index].data()['price'],
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: userCube.infractionsUserData!.length),
                          ):const SizedBox.shrink(),
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
