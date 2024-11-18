import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/features/auth/data/auth_firebase.dart';
import 'package:flutter_class_pal/features/auth/screens/auth_select_role/select_role_screen.dart';
import 'package:flutter_class_pal/features/user/data/user_firebase.dart';
import 'package:flutter_class_pal/routes/routes.dart';
import 'package:flutter_class_pal/screens/main_screen.dart';

import 'core/services/firebase/firebase_option.dart';
import 'core/themes/theme.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/user/bloc/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthFirebase())),
        BlocProvider(create: (context) => UserBloc(UserFirebase())),
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
        initialRoute: SelectRoleScreen.route,
      ),
    );
  }
}
