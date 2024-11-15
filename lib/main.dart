import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/repositories/routes/routes.dart';
import 'package:flutter_class_pal/repositories/theme/theme.dart';
import 'package:flutter_class_pal/screens/auth/select_role_screen.dart';
import 'package:flutter_class_pal/screens/main_screen.dart';

import 'features/auth/bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: 'ClassPal',
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: routes,
        initialRoute: MainScreen.route,
      ),
    );
  }
}
