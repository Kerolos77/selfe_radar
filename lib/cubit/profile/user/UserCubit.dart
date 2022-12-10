import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';
import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';

import '../../../data/firecase/firebase_reposatory.dart';
import '../../../utils/conestant/conestant.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic>? user;

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? infractionsUserData;

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  void getUserData() {
    emit(GetUserLoadingState());
    _firebaseReposatory.getUserData().then((value) {
      user = value.data() as Map<String, dynamic>;
      // setUserDataInCash();
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  void getUserInfractionsData() {
    emit(GetUserLoadingState());
    _firebaseReposatory.getUserInfractionsData().then((querySnapshot) {
      infractionsUserData = querySnapshot.docs;
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  void setUserDataInCash() {
    if (user!.isNotEmpty) {
      user!.forEach((key, value) {
        CacheHelper.putData(key: key, value: value);
      });
    }
  }

  void getUserDataFromCash() {
    constName = CacheHelper.getData(key: 'name');
    // constEmail = CacheHelper.getData(key: 'email');
    constNationalId = CacheHelper.getData(key: 'nationalID');
    constCarNumber = CacheHelper.getData(key: 'carNumber');
    emit(GetUserCachedSuccessState());
  }

  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessUserState());
  }

  void changeObscurePassFlag(flag) {
    obscurePassFlag = flag;
    emit(ChangeObscurePassFlagUserState());
  }

  void changeObscureConfirmFlag(flag) {
    obscureConfirmFlag = flag;
    emit(ChangeObscureConfirmFlagUserState());
  }
}
