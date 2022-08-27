class LoginModel{
  late bool status;
  LoginModel.fromJson(Map<String, dynamic >json){
    status = json['status'];
  }
}