abstract class RegistrationState {}

class InitialUserState extends RegistrationState {}

class SignUpSuccessUserState extends RegistrationState {}

class SignUpErrorUserState extends RegistrationState {
  late String error;

  SignUpErrorUserState(this.error);
}

class SignUpLoadingUserState extends RegistrationState {}

class LoginSuccessUserState extends RegistrationState {
  late String uId;

  LoginSuccessUserState(this.uId);
}

class LoginLoadingUserState extends RegistrationState {}

class LoginErrorUserState extends RegistrationState {
  late String error;

  LoginErrorUserState(this.error);
}

class CreateSuccessUserState extends RegistrationState {}

class CreateLoadingUserState extends RegistrationState {}

class CreateErrorUserState extends RegistrationState {
  late String error;

  CreateErrorUserState(this.error);
}

class LogOutSuccessUserState extends RegistrationState {}

class ChangeLoginUserNameUserState extends RegistrationState {}

class ChangeLoginPassUserState extends RegistrationState {}

class ChangePhoneUserState extends RegistrationState {}

class ChangePassConfirmFlagUserState extends RegistrationState {}

class ChangePassNumCharFlagUserState extends RegistrationState {}

class ChangeEmailFlagUserState extends RegistrationState {}

class ChangeObscurePassFlagUserState extends RegistrationState {}

class ChangeObscureConfirmFlagUserState extends RegistrationState {}

class ChangeNameUserState extends RegistrationState {}

class ChangeNationalIdUserState extends RegistrationState {}
