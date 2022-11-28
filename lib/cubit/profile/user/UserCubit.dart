

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfe_radar/cubit/profile/user/UserStates.dart';
import 'package:selfe_radar/utils/cach_helper/cache_helper.dart';

import '../../../data/firecase/firebase_reposatory.dart';

class UserCubit extends Cubit<UserStates>{
  UserCubit() : super(InitialUserState());

  static UserCubit get(context) => BlocProvider.of(context);

   Map<String, dynamic>? user ;

  FirebaseReposatory _firebaseReposatory = FirebaseReposatory();

  void getUserData(){
    emit(GetUserLoadingState());
    _firebaseReposatory.getUserData().then((value) {
       user = value.data() as Map<String, dynamic>;
      emit(GetUserSuccessState());
    }).catchError((error){
      emit(GetUserErrorState(error.toString()));
    });
  }

  void setUserDataInCash(){
    if(user!.isNotEmpty){
      user!.forEach((key, value) {
        CacheHelper.putData(key: key, value: value);
      });
    }
  }


}