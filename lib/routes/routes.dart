import 'package:flutter/material.dart';

import '../features/auth/screens/auth_login/login_screen.dart';
import '../features/auth/screens/auth_register/register_screen.dart';
import '../../screens/main_screen.dart';
import '../features/auth/screens/auth_select_role/select_role_screen.dart';
import '../features/class/screens/class_page/class_page_screen.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case MainScreen.route:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case SelectRoleScreen.route:
      return MaterialPageRoute(builder: (context) => const SelectRoleScreen());
    case RegisterScreen.route:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case ClassPageScreen.route:
      return MaterialPageRoute(builder: (context) => const ClassPageScreen());
    default:
      return MaterialPageRoute(builder: (context) => const MainScreen());
  }
}
