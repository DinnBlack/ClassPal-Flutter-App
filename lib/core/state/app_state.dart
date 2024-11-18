import 'package:flutter_class_pal/features/user/model/user_model.dart';

class AppState {
  static String? currentRole;
  static UserModel? currentUser;

  static String? getRole() {
    return currentRole;
  }

  static void setRole(String role) {
    currentRole = role;
  }

  static UserModel? getUser() {
    return currentUser;
  }

  static void setUser(UserModel user) {
    currentUser = user;
  }
}