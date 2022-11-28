
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/ui/componants/toast/toast.dart';

import '../../../cubit/profile/user/UserCubit.dart';
import '../../../cubit/profile/user/UserStates.dart';
import '../../../utils/conestant/conestant.dart';
import '../../componants/default_text/default_text.dart';
import '../../componants/default_text_field/default_text_field.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  int val = -1;
  TextEditingController locationControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  late File imageFile = File('assets/images/Profile Image.png');


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserCubit(),
        child: BlocConsumer<UserCubit, UserStates>(
            listener: (BuildContext context, UserStates state) {},
            builder: (BuildContext context, UserStates state) {
              UserCubit userCube = UserCubit.get(context);
              return Scaffold(
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
                                      Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 70,
                                            backgroundImage: AssetImage(imageFile.path),
                                          ),
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.blue.shade50,
                                            child: IconButton(onPressed: (){
                                              // pickImageFromGallery();
                                            }, icon: const Icon(Icons.edit,color: Colors.black,)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.06,
                                      ),
                                      defaultTextFiled(
                                        type: TextInputType.emailAddress,
                                        control: emailControl,
                                        prefixIcon: CupertinoIcons.t_bubble,
                                        iconColor: Colors.blue,
                                        hint: 'Name',
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      defaultTextFiled(
                                        type: TextInputType.emailAddress,
                                        control: emailControl,
                                        prefixIcon: CupertinoIcons.mail_solid,
                                        iconColor: Colors.blue,
                                        hint: 'Email',
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      defaultTextFiled(
                                        type: TextInputType.number,
                                        control: phoneControl,
                                        prefixIcon: CupertinoIcons.creditcard,
                                        iconColor: Colors.blue,
                                        hint: 'National ID',
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      defaultTextFiled(
                                        type: TextInputType.emailAddress,
                                        control: passwordControl,
                                        iconColor: Colors.blue,
                                        hint: 'Password',
                                        prefixIcon: userCube.obscurePassFlag
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                        suffixIcon: CupertinoIcons.lock_fill,
                                        obscure: userCube.obscurePassFlag,
                                        onPressSuffixIcon: () {
                                          userCube.changeObscurePassFlag(
                                              !userCube.obscurePassFlag);
                                        },
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      defaultTextFiled(
                                        type: TextInputType.emailAddress,
                                        control: confirmPasswordControl,
                                        iconColor: Colors.blue,
                                        hint: 'Confirm Password',
                                        prefixIcon: userCube.obscureConfirmFlag
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                        suffixIcon: CupertinoIcons.lock_fill,
                                        obscure: userCube.obscureConfirmFlag,
                                        onPressSuffixIcon: () {
                                          userCube.changeObscureConfirmFlag(
                                              !userCube.obscureConfirmFlag);
                                        },
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              elevation: 10,
                                              color: Colors.blue.shade100,
                                              child: Container(
                                                width:
                                                MediaQuery.of(context).size.width * 0.33,
                                                child: MaterialButton(
                                                  onPressed: () {},
                                                  child: defaultText(
                                                    text: 'Cancel',
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              elevation: 10,
                                              color: Colors.blue.shade100,
                                              child: Container(
                                                width:
                                                MediaQuery.of(context).size.width * 0.33,
                                                child: MaterialButton(
                                                  onPressed: () {},
                                                  child: defaultText(text: 'Save'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  Future<void> pickImageFromGallery() async {
    try{
      final PickedFile? imgFile = await ImagePicker.platform
          .pickImage(source: ImageSource.gallery);
      final File file = File(imgFile!.path);
      setState(() => imageFile = file);
    }catch(error){
      toast(msg:error.toString(), backColor: Colors.black, textColor: Colors.white);
    }
  }
}
