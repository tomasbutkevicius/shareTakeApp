import 'dart:convert';

import 'package:share_take/data/models/user/user_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserSource {
  static const _keyActiveUser = "user";
  static const _keyUserList = "users";
  static const testUserName = "demo@byl.example.com";
  static const int testUserId = 000;

  Future addUser(UserLocal user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<UserLocal> oldUserList = await getStoredUsers();
    List<Map<String, dynamic>> newUserList = [];

    for (var user in oldUserList) {
      newUserList.add(user.toJson());
    }

    print("DB adding new user ${user.username}");

    newUserList.add(user.toJson());

    await prefs.setString(_keyUserList, jsonEncode(newUserList));
  }

  Future<UserLocal?> findUserById(int id) async {
    List<UserLocal> oldUserList = await getStoredUsers();

    for (var user in oldUserList) {
      if (user.id == id) {
        print("DB user found");
        return user;
      }
    }
    print("DB user not found");
    return null;
  }

  Future<UserLocal?> findUserByEmail(String email) async {
    List<UserLocal> oldUserList = await getStoredUsers();

    for (var user in oldUserList) {
      if (user.email == email) {
        print("DB user found");
        return user;
      }
    }
    print("DB user not found");
    return null;
  }

  Future updateUser(UserLocal user) async {
    List<UserLocal> userList = await getStoredUsers();
    List<Map<String, dynamic>> newUserList = [];

    for (UserLocal userInList in userList) {
      if (userInList.id == user.id) {
        userInList = user;
        await setActiveUser(user);
        print("DB: updating user ${user.id}");
      }
      newUserList.add(userInList.toJson());
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserList, jsonEncode(newUserList));
  }

  Future<List<UserLocal>> getStoredUsers() async {
    print("DB Getting users in local storage");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String rawData = prefs.getString(_keyUserList) ?? "";

    if (rawData.isEmpty) {
      print("DB Found no stored users");

      return [];
    } else {
      print("DB Found user list:");
      List<dynamic> userMapList = jsonDecode(rawData) as List<dynamic>;
      List<UserLocal> userList = [];

      for (var userMap in userMapList) {
        UserLocal user = UserLocal.fromJson(userMap as Map<String, dynamic>);
        print(user.username);
        userList.add(user);
      }

      return userList;
    }
  }

  Future setActiveUser(UserLocal user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_keyActiveUser, jsonEncode(user.toJson()));
  }

  Future removeActiveUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_keyActiveUser);
  }

  Future<UserLocal?> getActiveUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userRaw = sharedPreferences.getString(_keyActiveUser);

    if (userRaw == null) {
      return null;
    }
    print("DB Found active user");
    Map<String, dynamic> jsonUser = jsonDecode(userRaw) as Map<String, dynamic>;
    return UserLocal.fromJson(jsonUser);
  }
}
