import 'package:shared_preferences/shared_preferences.dart';

class SharedPreHelper {
  static late SharedPreferences sharedpre;

  //inits SharedPredfrences
  static Future<SharedPreferences> initSharedPredFrencese() async {
    return sharedpre = await SharedPreferences.getInstance();
  }

  // set Data
  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) return await sharedpre.setInt(key, value);
    if (value is String) return await sharedpre.setString(key, value);
    if (value is bool) return await sharedpre.setBool(key, value);
    return await sharedpre.setDouble(key, value);
  }

  //get Data
  static dynamic getData({required String? key}) {
    return sharedpre.get(key!);
  }

  //clear Data
  static Future<bool> clearData() async{
   return await sharedpre.clear();
  }
}
