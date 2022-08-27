class RegisterModel {
  late String massege;
  late UserModel userModel;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    massege = json['massege'];
    userModel = UserModel.fromJson(json['user']);
  }
}

class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}
