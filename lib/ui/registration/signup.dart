import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selfe_radar/ui/componants/toast/toast.dart';

import '../../cubit/registration/registrationCubit.dart';
import '../../cubit/registration/registrationStates.dart';
import '../componants/default_buttons/defult_button.dart';
import '../componants/default_text/default_text.dart';
import '../componants/default_text_field/default_text_field.dart';
import '../componants/text_field_lable/text_field_lable.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  TextEditingController nationalIDControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController carNumberControl = TextEditingController();

  PickedFile img = PickedFile('');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          print(state);
          if (state is SignUpErrorUserState) {
            toast(
                msg: "this user is already exist or filed to connect",
                backColor: Colors.black38,
                textColor: Colors.white);
          }
          if (state is CreateSuccessUserState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ));
          }
        },
        builder: (context, state) {
          RegistrationCubit registrationCub = RegistrationCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: defaultText(
                                text: "Welcome",
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFiled(
                            type: TextInputType.emailAddress,
                            control: nameControl,
                            prefixIcon: CupertinoIcons.t_bubble,
                            hint: 'User Name',
                            onchange: (value) {
                              if (!value.isEmpty) {
                                registrationCub.changeNameFlag(true);
                              } else {
                                registrationCub.changeNameFlag(false);
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textRegester(text: 'ex : Ahmed'),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: registrationCub.nameFlag
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          defaultTextFiled(
                            type: TextInputType.emailAddress,
                            control: emailControl,
                            prefixIcon: CupertinoIcons.mail,
                            hint: 'Email',
                            onchange: (value) {
                              if (!value.isEmpty &&
                                  value.contains('@') &&
                                  value.contains('.com') &&
                                  !value.contains(' ')) {
                                registrationCub.changeEmailFlag(true);
                              } else {
                                registrationCub.changeEmailFlag(false);
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textRegester(text: 'ex : example@gmail.com'),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: registrationCub.emailFlag
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          defaultTextFiled(
                            type: TextInputType.emailAddress,
                            control: nationalIDControl,
                            prefixIcon: CupertinoIcons.creditcard,
                            hint: 'National ID',
                            onchange: (value) {
                              if (value.isNotEmpty && value.length == 14) {
                                registrationCub.changeNationalIdFlag(true);
                              } else {
                                registrationCub.changeNationalIdFlag(false);
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textRegester(text: 'ex : 12345678901234'),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: registrationCub.nationalIdFlag
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          defaultTextFiled(
                            type: TextInputType.text,
                            control: carNumberControl,
                            prefixIcon: CupertinoIcons.creditcard,
                            hint: 'Car Number',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFiled(
                              type: TextInputType.visiblePassword,
                              obscure: registrationCub.obscurePassFlag,
                              suffixIcon: registrationCub.obscurePassFlag
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              control: passwordControl,
                              prefixIcon: CupertinoIcons.lock,
                              hint: 'Password',
                              onPressSuffixIcon: () {
                                registrationCub.changeObscurePassFlag(
                                    !registrationCub.obscurePassFlag);
                              },
                              onchange: (value) {
                                if (!value.isEmpty &&
                                    value.toString().length >= 8 &&
                                    value == confirmPasswordControl.text) {
                                  registrationCub.changePassNumCharFlag(true);
                                } else {
                                  registrationCub.changePassNumCharFlag(false);
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textRegester(text: 'ex : xxxxxxxx'),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: registrationCub.passNumChar
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          defaultTextFiled(
                              type: TextInputType.visiblePassword,
                              obscure: registrationCub.obscureConfirmFlag,
                              suffixIcon: registrationCub.obscureConfirmFlag
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              control: confirmPasswordControl,
                              prefixIcon: CupertinoIcons.lock,
                              hint: 'Confirm Password',
                              onPressSuffixIcon: () {
                                registrationCub.changeObscureConfirmFlag(
                                    !registrationCub.obscureConfirmFlag);
                              },
                              onchange: (value) {
                                if (!value.isEmpty &&
                                    value == passwordControl.text) {
                                  registrationCub.changePassConfirmFlag(true);
                                } else {
                                  registrationCub.changePassConfirmFlag(false);
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textRegester(text: 'ex : Not Identical Password'),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: registrationCub.passConfirmFlag
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginSuccessUserState,
                            builder: (context) => defaultButton(
                                isDone: registrationCub.emailFlag &&
                                    registrationCub.passNumChar &&
                                    registrationCub.passConfirmFlag &&
                                    registrationCub.nameFlag,
                                text: 'Sign Up',
                                context: context,
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    registrationCub.signUp(
                                        name: nameControl.text,
                                        email: emailControl.text,
                                        password: passwordControl.text,
                                        nationalID: nationalIDControl.text,
                                        carNumber: carNumberControl.text);
                                  }
                                }),
                            fallback: (context) =>
                                const CupertinoActivityIndicator(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultText(
                                  text: 'Already have an account ?',
                                  size: 10,
                                  color: Colors.black),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ));
                                  print('Login');
                                },
                                child: defaultText(
                                    text: 'Login',
                                    size: 10,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
