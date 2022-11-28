import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selfe_radar/data/firecase/firebase_reposatory.dart';
import 'package:selfe_radar/test.dart';
import 'package:selfe_radar/ui/componants/alert_function/alert_function.dart';
import 'package:selfe_radar/ui/home/home.dart';
import 'package:selfe_radar/ui/profile/user/user.dart';
import 'package:selfe_radar/ui/registration/login.dart';
import 'package:selfe_radar/ui/styles/colors.dart';
import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';
import 'package:selfe_radar/utils/conestant/conestant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseReposatory.initFirebase();
  await CacheHelper.init();
  Widget widget;
  String? uId = CacheHelper.getData(key: 'user');

  if (uId != null && uId != '') {
    constUid = uId;
    widget = Home();
  } else {
    widget = const Login();
  }
  // widget = const UserProfile();

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  late Widget stWidget;

  MyApp({required Widget startWidget}) {
    stWidget = startWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: primarywihte,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0.0,
              )),
          home: stWidget,
        );

      },
    );
  }
}
