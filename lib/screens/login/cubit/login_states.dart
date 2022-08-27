import 'package:shop/models/login_model.dart';

abstract class LoginStates {}
class InitsLogin extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates {}

class ChangePasswordvisibilityState extends LoginStates {}
