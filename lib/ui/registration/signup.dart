import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfe_radar/ui/componants/toast/toast.dart';
import '../../cubit/registration/registrationCubit.dart';
import '../../cubit/registration/registrationStates.dart';
import '../componants/connection/no_connection.dart';
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
  TextEditingController phoneControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          print(state);
          if (state is SignUpErrorUserState) {
            toast(msg: state.error,
                backColor: Colors.red[20]!,
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
              body: SafeArea(
                child: noConnectionCard(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Image(
                              image: AssetImage(
                                'assets/images/Time management.png',
                              ),
                              fit: BoxFit.scaleDown,
                              // height: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: defaultText(
                                text: "Welcome",
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                            registrationCub.emailFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : example@gmail.com'),
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
                            registrationCub.nameFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : Attendants'),
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
                                      value.toString().length >= 8) {
                                    registrationCub.changePassNumCharFlag(true);
                                  } else {
                                    registrationCub.changePassNumCharFlag(false);
                                  }
                                  if (value == confirmPasswordControl.text) {
                                    registrationCub.changePassConfirmFlag(true);
                                  } else {
                                    registrationCub.changePassConfirmFlag(false);
                                  }
                                }),
                            registrationCub.passNumChar
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : 12345678'),
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
                            registrationCub.passConfirmFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(
                                    text: 'ex : Not Identical Password'),

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
                                          password: passwordControl.text);
                                    }
                                  }),
                              fallback: (context) =>
                              const CupertinoActivityIndicator(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginSuccessUserState,
                              builder: (context) => defaultButton(
                                  color: Colors.red,
                                  isDone: true,
                                  text: 'Login with Google',
                                  imagePath: 'assets/images/google.png',
                                  context: context,
                                  onPress: () {
                                    registrationCub.logInWithGoogle();
                                  }),
                              fallback: (context) =>
                              const CupertinoActivityIndicator(),
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
              ));
        },
      ),
    );
  }
}
