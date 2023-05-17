import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hello_flutter/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database/db.dart';

class AuthService {
  static SharedPreferences? sharedPref;

  static Future<SharedPreferences> createPref() async {
    if (sharedPref != null) {
      return sharedPref!;
    }
    sharedPref = await SharedPreferences.getInstance();
    return sharedPref!;
  }

  static Future createUser(User user) async{
    TasksDatabase.createUser(user);
  }

  static Future<bool> isLoggedIn() async {
    final user = await getUser();
    return user != null;
  }

  static Future<void> authenticate(String email, String pass, Function(bool) callback) async {
    final String hashedPassword = md5.convert(utf8.encode(pass)).toString();
    final res = await TasksDatabase.getUserByEmail(email);
    if(res.isEmpty){
      callback(false);
    }
    final User authUser = User.fromMap(res[0]);

    if(authUser.password != hashedPassword){
      callback(false);
    }
    final sharedPref = await createPref();
    final user = authUser.toMap();
    user["id"] = authUser.id;
    user["image"] = null;
    final userString = jsonEncode(user);
    sharedPref.setString("user", userString);
    callback(true);
  }

  static Future deAuthenticate() async {
    final sharedPref = await createPref();
    sharedPref.remove("user");
  }

  static Future<User?> getUser() async {
    final sharedPref = await createPref();
    final userString = sharedPref.getString("user");
    if (userString != null) return User.fromMap(jsonDecode(userString));
    return null;
  }
}
