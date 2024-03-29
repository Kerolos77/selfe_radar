import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfe_radar/cubit/map/mapCubit.dart';
import 'package:selfe_radar/ui/map/mapScreen.dart';

import '../profile/user/user.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var screens = [
    BlocProvider(
      create: (BuildContext context) => MapCubit()..getMyLocation(),
      child: const MapScreen(),
    ),
    const UserProfile(),
  ];
  var screenIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         setState(() {
      //           screenIndex = 1;
      //         });
      //       },
      //       icon: const Icon(FontAwesomeIcons.user),
      //     ),
      //   ],
      //   leading: IconButton(
      //     onPressed: () {
      //       setState(() {
      //         screenIndex = 0;
      //       });
      //     },
      //     icon: const Icon(FontAwesomeIcons.map),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.map), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Me',
          ),
        ],
        currentIndex: screenIndex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        elevation: 0,
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: screens[screenIndex],
      ),
    );
  }
}
