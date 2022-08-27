import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/screens/login/cubit/login_states.dart';
import 'package:shop/shared/network/remote/http_endpoints.dart';
import 'package:shop/shared/network/remote/http_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitsLogin());
  static LoginCubit get(context) => BlocProvider.of(context);

  //changePassword
  bool ispasswordVisibility = true;
  changePasswordvisibility() {
    ispasswordVisibility = !ispasswordVisibility;
    emit(ChangePasswordvisibilityState());
  }

//login
  LoginModel? loginModel;
  postLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    HttpHelper.postData(
        url: login, data: {"email": email, "password": password}
        ).then((value) {
      loginModel = LoginModel.fromJson(jsonDecode(value.body));
      emit(LoginSuccessState(loginModel!));
      print(value.statusCode);
    }).catchError((error) {
      print(error);
      emit(LoginErrorState());
    });
  }
}
