import 'dart:convert';

import 'package:share_take/data/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserSource {
  static const _keyActiveUser = "user";
  static const _keyUserList = "users";
  static const testUserName = "demo@byl.example.com";
  static const int testUserId = 000;

  Future addUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<User> oldUserList = await getStoredUsers();
    List<Map<String, dynamic>> newUserList = [];

    for (var user in oldUserList) {
      newUserList.add(user.toJson());
    }

    print("DB adding new user ${user.username}");

    newUserList.add(user.toJson());

    await prefs.setString(_keyUserList, jsonEncode(newUserList));
  }

  Future<User?> findUserById(int id) async {
    List<User> oldUserList = await getStoredUsers();

    for (var user in oldUserList) {
      if (user.id == id) {
        print("DB user found");
        return user;
      }
    }
    print("DB user not found");
    return null;
  }

  Future<User?> findUserByEmail(String email) async {
    List<User> oldUserList = await getStoredUsers();

    for (var user in oldUserList) {
      if (user.email == email) {
        print("DB user found");
        return user;
      }
    }
    print("DB user not found");
    return null;
  }

  Future updateUser(User user) async {
    List<User> userList = await getStoredUsers();
    List<Map<String, dynamic>> newUserList = [];

    for (User userInList in userList) {
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

  Future<List<User>> getStoredUsers() async {
    print("DB Getting users in local storage");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String rawData = prefs.getString(_keyUserList) ?? "";

    if (rawData.isEmpty) {
      print("DB Found no stored users");

      return [];
    } else {
      print("DB Found user list:");
      List<dynamic> userMapList = jsonDecode(rawData) as List<dynamic>;
      List<User> userList = [];

      for (var userMap in userMapList) {
        User user = User.fromJson(userMap as Map<String, dynamic>);
        print(user.username);
        userList.add(user);
      }

      return userList;
    }
  }

  Future setActiveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_keyActiveUser, jsonEncode(user.toJson()));
  }

  Future removeActiveUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_keyActiveUser);
  }

  Future<User?> getActiveUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userRaw = sharedPreferences.getString(_keyActiveUser);

    if (userRaw == null) {
      return null;
    }
    print("DB Found active user");
    Map<String, dynamic> jsonUser = jsonDecode(userRaw) as Map<String, dynamic>;
    return User.fromJson(jsonUser);
  }

  Future authenticate({required String email, required String password}) async {
    User? foundUser = await findUserByEmail(email);

    if(foundUser != null){
      return foundUser;
    }


      List<User> users = await getStoredUsers();
      addUser(User(
        id: users.length + 1,
        token: "demo",
        username: "demo",
        email: email,
        firstName: "demo",
        lastName: "demo",
      ));
  }
}
