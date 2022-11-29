import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfe_radar/cubit/map/mapCubit.dart';
import 'package:selfe_radar/ui/map/mapScreen.dart';
import 'package:selfe_radar/ui/profile/user/user.dart';

import '../../utils/conestant/conestant.dart';
import '../profile/user/edit_user.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var screens = [
    BlocProvider(
      create: (BuildContext context) => MapCubit(),
      child: const MapScreen(),
    ),
    const UserProfile(),
  ];
  var screenIndex = crruntIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                screenIndex = 1;
              });
            },
            icon: const Icon(CupertinoIcons.profile_circled),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            setState(() {
              screenIndex = 0;
            });
          },
          icon: const Icon(CupertinoIcons.map),
        ),
      ),
      body: screens[screenIndex],
    );
  }
}
