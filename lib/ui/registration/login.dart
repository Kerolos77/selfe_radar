import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:selfe_radar/ui/profile/admin/admin.dart';
import 'package:selfe_radar/ui/registration/signup.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';

import '../../cubit/registration/registrationCubit.dart';
import '../../cubit/registration/registrationStates.dart';
import '../../utils/animation_enum.dart';
import '../../utils/cach_helper/cache_helper.dart';
import '../componants/default_buttons/defult_button.dart';
import '../componants/default_text/default_text.dart';
import '../componants/default_text_field/default_text_field.dart';
import '../componants/text_field_lable/text_field_lable.dart';
import '../componants/toast/toast.dart';
import '../home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  Artboard? riveArtboard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String testEmail = "mohamed.hassan@gmail.com";
  String testPassword = "123456";
  final passwordFocusNode = FocusNode();

  bool isLookingLeft = false;
  bool isLookingRight = false;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerIdle);
    debugPrint("idleee");
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsUp);
    debugPrint("hands up");
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsDown);
    debugPrint("hands down");
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerSuccess);
    debugPrint("Success");
  }

  void addFailController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerFail);
    debugPrint("Faillll");
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtboard?.artboard.addController(controllerLookRight);
    debugPrint("Righttt");
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerLookLeft);
    debugPrint("Leftttttt");
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    rootBundle.load('assets/animations/animated_login_screen.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      setState(() {
        riveArtboard = artboard;
      });
    });

    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addSuccessController();
      } else {
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegistrationCubit(),
        child: BlocConsumer<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is LoginErrorUserState) {
              toast(
                  msg: "User Name or Password is incorrect or filed to connect",
                  backColor: Colors.grey.shade300,
                  textColor: Colors.black);
            }
            if (state is LoginSuccessUserState) {
              CacheHelper.saveData(key: "user", value: state.uId).then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              });
              toast(
                  msg: "you are welcome",
                  backColor: Colors.grey.shade300,
                  textColor: Colors.black);
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: riveArtboard == null
                                  ? const SizedBox.shrink()
                                  : Rive(
                                      artboard: riveArtboard!,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: defaultText(
                                text: "Welcome Back",
                                size: 15,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFiled(
                                type: TextInputType.emailAddress,
                                control: userNameControl,
                                prefixIcon: CupertinoIcons.mail,
                                hint: "Email",
                                onchange: (value) {
                                  if (value.isNotEmpty) {
                                    if (value.length < 16 && !isLookingLeft) {
                                      addLookLeftController();
                                    } else if (value.length > 16 &&
                                        !isLookingRight) {
                                      addLookRightController();
                                    }
                                    registrationCub
                                        .changeLoginUserNameFlag(true);
                                  } else {
                                    registrationCub
                                        .changeLoginUserNameFlag(false);
                                  }
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textRegester(text: 'ex : example@gmail.com'),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: registrationCub.loginUserNameFlag
                                        ? Colors.green
                                        : Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ],
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
                              focusNode: passwordFocusNode,
                              onchange: (value) {
                                if (!value.isEmpty) {
                                  registrationCub.changeLoginPassFlag(true);
                                } else {
                                  registrationCub.changeLoginPassFlag(false);
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textRegester(text: 'ex : xxxxxxxx'),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Icon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: registrationCub.loginPassFlag
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
                                  isDone: registrationCub.loginPassFlag &&
                                      registrationCub.loginUserNameFlag,
                                  text: 'Login',
                                  context: context,
                                  onPress: () {
                                    passwordFocusNode.unfocus();
                                    if (formKey.currentState!.validate()) {
                                      if (userNameControl.text ==
                                              "admin@admin.com" &&
                                          passwordControl.text == "admin") {
                                        CacheHelper.putData(
                                            key: "user", value: "admin");
                                        constUid = "admin";
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminProfile(),
                                            ));
                                      } else {
                                        print("${state}++++++++++++++++++++++");
                                        print(userNameControl.text);
                                        print(passwordControl.text);
                                        registrationCub.login(
                                            email: userNameControl.text,
                                            password: passwordControl.text);
                                      }
                                    }
                                  }),
                              fallback: (context) =>
                                  const CupertinoActivityIndicator(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                defaultText(
                                  text: 'Don\'t have an account ?',
                                  size: 10,
                                  color: Colors.black,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SignUp(),
                                        ));
                                  },
                                  child: defaultText(
                                    text: 'Sign Up',
                                    size: 10,
                                    color: Colors.blue,
                                  ),
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
        ));
  }
}
