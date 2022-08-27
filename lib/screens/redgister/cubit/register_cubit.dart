import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/register_model.dart';
import 'package:shop/screens/redgister/cubit/register_states.dart';
import 'package:shop/shared/network/remote/http_endpoints.dart';
import 'package:shop/shared/network/remote/http_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitsRegister());
  static RegisterCubit get(context) => BlocProvider.of(context);

  //changePassword
  bool ispasswordVisibility = true;
  changePasswordvisibility() {
    ispasswordVisibility = !ispasswordVisibility;
    emit(ChangePasswordvisibilityState());
  }

 //register
  RegisterModel? registerModel;
  postRegister(
      {required String name,
      required String email,
      required String phone,
      required String password}) {
    emit(RegisterLoadingState());
    
    HttpHelper.postData(url: users, data: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    }).then((value) {
      registerModel = RegisterModel.fromJson(jsonDecode(value.body));
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState());
    });
  }

}
