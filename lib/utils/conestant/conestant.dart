//
// String? constUid = "";
// String? constName = "";
// String? constEmail = "";
// String? constNationalId = "";
// String? constCarNumber = "";
//
//
// int crruntIndex = 0;


import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';

String? constUid = "";
String? constName = CacheHelper.getData(key: 'name');
// String? constEmail = CacheHelper.getData(key: 'userEmail');
String? constNationalId =  CacheHelper.getData(key: 'nationalID');
String? constCarNumber = CacheHelper.getData(key: 'carNumber');


int crruntIndex = 0;
