abstract class UserStates {}

class InitialUserState extends UserStates {}

class GetUserLoadingState extends UserStates {}

class GetUserSuccessState extends UserStates {}

class GetUserCachedSuccessState extends UserStates {}

class GetUserErrorState extends UserStates {
  final String error;

  GetUserErrorState(this.error);
}
class ChangeObscurePassFlagUserState extends UserStates {}

class ChangeObscureConfirmFlagUserState extends UserStates {}

class LogOutSuccessUserState extends UserStates {}

