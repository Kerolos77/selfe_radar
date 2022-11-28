
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';
import '../../../cubit/profile/user/UserCubit.dart';
import '../../componants/alert_function/alert_function.dart';
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
              if((constName == ""&& constName == null) &&
              (constEmail == ""&& constEmail == null) &&
              (constNationalId == ""&& constNationalId == null) &&
              (constCarNumber == ""&& constCarNumber == null)){
                userCube.getUserData();
              }
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
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
                                          text: "$constName", size: 20),
                                      carNumber(number: "$constCarNumber"),
                                    ],
                                  ),
                                  // IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                  alert(
                            context: context,
                          currentSpeed: 60,
                          preSpeed: 50,
                          name: "kerolofaie",
                          price: "100 lE" ,
                    carNumber: "ب ط ن 111",
                    nationalId: "123456789",
                        ),
                        // ListView.separated(
                        //     itemBuilder: (context, index) =>
                        //     alert(
                        //         context: context,
                        //       currentSpeed: 60,
                        //       preSpeed: 50,
                        //       name: "kerolofaie",
                        //       price: "100 lE" ,
                        //     ),
                        //     separatorBuilder: (context, index) => const SizedBox(
                        //       height: 10
                        //     ),
                        //     itemCount: 15)
                        
                      ],
                    ),
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
