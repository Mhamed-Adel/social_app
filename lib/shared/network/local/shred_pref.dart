import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
static  late SharedPreferences sharedPreferences;
  static init() async{
  sharedPreferences= await  SharedPreferences.getInstance();

  }

  static Future<bool> saveData({
    required String key,
    required value,
  })async {
  
  if(value is bool) return await sharedPreferences.setBool(key, value);
  if(value is String) return await sharedPreferences.setString(key, value);
  if(value is double) return await sharedPreferences.setDouble(key, value);
  return await
  sharedPreferences.setInt(key, value);
  
  }

  static dynamic getData(
    String key
  ){
    sharedPreferences.get(key);
  }
}
