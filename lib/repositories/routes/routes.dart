import 'package:flutter/material.dart';

import '../../screens/auth/register_screen.dart';
import '../../screens/auth/select_role_screen.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case SelectRoleScreen.route:
      return MaterialPageRoute(builder: (context) => const SelectRoleScreen());
  case RegisterScreen.route:
  return MaterialPageRoute(builder: (context) => const RegisterScreen());
    default:
      return MaterialPageRoute(builder: (context) => const SelectRoleScreen());
  }
}