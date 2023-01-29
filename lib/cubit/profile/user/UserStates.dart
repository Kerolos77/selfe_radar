abstract class UserStates {}

class InitialUserState extends UserStates {}

class GetUserLoadingState extends UserStates {}

class GetUserSuccessState extends UserStates {}

class GetInfractionSuccessState extends UserStates {}

class GetUserCachedSuccessState extends UserStates {}

class GetUserErrorState extends UserStates {
  final String error;

  GetUserErrorState(this.error);
}

class GetInfractionErrorState extends UserStates {
  final String error;

  GetInfractionErrorState(this.error);
}

class ChangeObscurePassFlagUserState extends UserStates {}

class ChangeObscureConfirmFlagUserState extends UserStates {}

class LogOutSuccessUserState extends UserStates {}

