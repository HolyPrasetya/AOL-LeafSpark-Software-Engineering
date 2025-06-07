import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _id = "";
  String _username = "Pikachu";
  String _bio = "I love gardening";
  String _email = "7ason3van@gmail.com";
  String _phone = '0895413315500';

  String get id => _id;
  String get username => _username;
  String get bio => _bio;
  String get email => _email;
  String get phone => _phone;

  void setId(String id) {
    _id = id;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setBio(String bio) {
    _bio = bio;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }
}
