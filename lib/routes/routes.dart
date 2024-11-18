import 'package:flutter/material.dart';
import '../features/auth/screens/auth_screen.dart';
import '../../screens/main_screen.dart';
import '../features/auth/screens/auth_select_role/select_role_screen.dart';
import '../features/class/screens/class_main_screen.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case MainScreen.route:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case SelectRoleScreen.route:
      return MaterialPageRoute(builder: (context) => const SelectRoleScreen());
    case AuthScreen.route:
      return MaterialPageRoute(builder: (context) => const AuthScreen());
    case ClassMainScreen.route:
      return MaterialPageRoute(builder: (context) => const ClassMainScreen());
    default:
      return MaterialPageRoute(builder: (context) => const MainScreen());
  }
}
