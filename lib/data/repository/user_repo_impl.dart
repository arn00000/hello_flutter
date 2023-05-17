import 'dart:typed_data';

import 'package:hello_flutter/data/database/db.dart';
import '../model/user.dart';

class UserRepoImpl {
  Future<int> insertUser(User user) async {
    return await TasksDatabase.createUser(user);
  }

  Future<List<User>> getUsers() async {
    final res = await TasksDatabase.getUsers();
    return res.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getUserByEmail(String email) async {
    final res = await TasksDatabase.getUserByEmail(email);
    if (res.isEmpty) {
      return null;
    }
    return User.fromMap(res[0]);
  }

  Future updateProfilePic(int userId, Uint8List image) async {
    TasksDatabase.updateProfilePic(userId, image);
  }
}
