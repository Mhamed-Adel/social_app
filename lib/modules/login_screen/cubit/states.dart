abstract class LoginSocialStates {}

class LoginSocialInitialState extends LoginSocialStates{}
class LoginSocialLoadingState extends LoginSocialStates{}
class LoginSocialSuccessState extends LoginSocialStates{
  final String uId;

  LoginSocialSuccessState(this.uId);
}
class LoginSocialErrorState extends LoginSocialStates{
  final String error;

  LoginSocialErrorState(this.error);
}
class ChangePasswordVisibilty extends LoginSocialStates{}