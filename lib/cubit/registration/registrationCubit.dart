import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfe_radar/data/firecase/firebase_reposatory.dart';
import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';

import '../../utils/conestant/conestant.dart';
import 'registrationStates.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(InitialUserState());

  bool loginUserNameFlag = false;

  bool loginPassFlag = false;

  bool emailFlag = false;

  bool passNumChar = false;

  bool passConfirmFlag = false;

  bool obscurePassFlag = true;

  bool obscureConfirmFlag = true;

  bool nameFlag = false;

  bool nationalIdFlag = false;

  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  static RegistrationCubit get(context) => BlocProvider.of(context);

  void createUser({
    required String name,
    required String email,
    required String id,
    required String password,
    required String nationalID,
    required String carNumber,
  }) async {
    emit(CreateLoadingUserState());
    await firebaseReposatory
        .createUser(
            name: name,
            email: email,
            id: id,
            password: password,
            nationalID: nationalID,
            carNumber: carNumber)
        .then((value) {
      emit(CreateSuccessUserState());
    }).catchError((error) {
      CreateErrorUserState(error.toString());
    });
  }

  ///// fire Auth function
  void signUp({
    required String name,
    required String email,
    required String password,
    required String nationalID,
    required String carNumber,
  }) {
    emit(SignUpLoadingUserState());
    firebaseReposatory
        .signUp(
      name: name,
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
          email: email,
          name: name,
          id: value.user!.uid,
          nationalID: nationalID,
          password: password,
          carNumber: carNumber);
      CacheHelper.saveData(key: 'name', value: '');
      CacheHelper.saveData(key: 'nationalID', value: '');
      CacheHelper.saveData(key: 'carNumber', value: '');
      CacheHelper.saveData(key: 'cardNumber', value: '');
      CacheHelper.saveData(key: 'cardHolder', value: '');
      CacheHelper.saveData(key: 'cardMonth', value: '');
      CacheHelper.saveData(key: 'cardYear', value: '');
      CacheHelper.saveData(key: 'cardCvv', value: '');
      CacheHelper.saveData(key: 'National ID Image', value: '');
      CacheHelper.saveData(key: 'Car Number Image', value: '');
      CacheHelper.saveData(key: 'Driving License Image', value: '');
    }).catchError((error) {
      emit(SignUpErrorUserState(error.toString()));
    });
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingUserState());
    firebaseReposatory.login(email: email, password: password).then((value) {
      constUid = value.user!.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(constUid)
          .get()
          .then((value) {
        CacheHelper.saveData(key: 'name', value: value.data()!['name']);
        CacheHelper.saveData(
            key: 'nationalID', value: value.data()!['nationalID']);
        CacheHelper.saveData(
            key: 'carNumber', value: value.data()!['carNumber']);
      });
      emit(LoginSuccessUserState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorUserState(error.toString()));
    });
  }

  void changeObscurePassFlag(flag) {
    obscurePassFlag = flag;
    emit(ChangeObscurePassFlagUserState());
  }

  void changeObscureConfirmFlag(flag) {
    obscureConfirmFlag = flag;
    emit(ChangeObscureConfirmFlagUserState());
  }

  void changeEmailFlag(flag) {
    emailFlag = flag;
    emit(ChangeEmailFlagUserState());
  }

  void changePassNumCharFlag(flag) {
    passNumChar = flag;
    emit(ChangePassNumCharFlagUserState());
  }

  void changePassConfirmFlag(flag) {
    passConfirmFlag = flag;
    emit(ChangePassConfirmFlagUserState());
  }

  void changeLoginUserNameFlag(flag) {
    loginUserNameFlag = flag;
    emit(ChangeLoginUserNameUserState());
  }

  void changeLoginPassFlag(flag) {
    loginPassFlag = flag;
    emit(ChangeLoginPassUserState());
  }

  void changeNameFlag(flag) {
    nameFlag = flag;
    emit(ChangeNameUserState());
  }

  void changeNationalIdFlag(flag) {
    nationalIdFlag = flag;
    emit(ChangeNationalIdUserState());
  }
}
