import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:instragram_firebase/models/user.dart';
import 'package:instragram_firebase/resources/auth_methods.dart';
import 'package:instragram_firebase/models/user.dart' as model;

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethods = AuthMethods();
  bool isdataloading = true;
  User? user;
  Future<User> refreshUser() async {
    log("inside");
    try {
      user = await AuthMethods().getUserDetails();
      isdataloading = false;
    } catch (e) {
      isdataloading = true;
    }
    return user!;
  }
  // User? user;
  // final AuthMethods _authMethods = AuthMethods();

  // // User get getUser => _user!;

  // Future<User> refreshUser() async {
  //   User user = await _authMethods.getUserDetails();
  //   user = user;
  //   notifyListeners();
  //   return user;
  // }
}
