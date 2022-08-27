

import 'package:shop/models/register_model.dart';

abstract class RegisterStates {}
class InitsRegister extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {
  RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends RegisterStates {}

class ChangePasswordvisibilityState extends RegisterStates {}
