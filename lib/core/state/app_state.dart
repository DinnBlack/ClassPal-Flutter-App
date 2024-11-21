import 'package:flutter_class_pal/features/user/model/user_model.dart';

import '../../features/class/model/class_model.dart';

class AppState {
  static String? currentRole;
  static UserModel? currentUser;
  static ClassModel? currentClass;

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

  static ClassModel? getClass() {
    return currentClass;
  }

  static void setClass(ClassModel value) {
    currentClass = value;
  }
}