import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';
import 'package:flutter_class_pal/features/auth/screens/auth_select_role/select_role_screen.dart';
import 'package:flutter_class_pal/features/class/bloc/class_bloc.dart';
import 'package:flutter_class_pal/features/class/data/class_firebase.dart';
import 'package:flutter_class_pal/features/user/data/user_firebase.dart';
import 'package:flutter_class_pal/routes/routes.dart';
import 'package:flutter_class_pal/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/firebase/firebase_option.dart';
import 'core/state/app_state.dart';
import 'core/themes/theme.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/data/auth_firebase.dart';
import 'features/class/bloc/subject/subject_cubit.dart';
import 'features/post/bloc/post_bloc.dart';
import 'features/student/bloc/student/create/student_create_bloc.dart';
import 'features/student/bloc/student/fetch/student_fetch_bloc.dart';
import 'features/student/bloc/student_group/student_group_bloc.dart';
import 'features/student/data/student_firebase.dart';
import 'features/user/bloc/user_bloc.dart';
import 'features/user/model/user_model.dart';

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
        BlocProvider(create: (context) => ClassBloc(ClassFirebase())),
        BlocProvider(create: (context) => PostBloc(ClassFirebase())),
        BlocProvider(create: (context) => SubjectCubit(ClassFirebase())),

        //Student Bloc
        BlocProvider(create: (context) => StudentFetchBloc(StudentFirebase())),
        BlocProvider(
            create: (context) => StudentCreateBloc(
                StudentFirebase(), context.read<StudentFetchBloc>())),
        BlocProvider(create: (context) => StudentGroupBloc(StudentFirebase())),
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
        home: FutureBuilder<bool>(
          future: _checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingDialog();
            } else if (snapshot.hasData) {
              bool isLoggedIn = snapshot.data ?? false;
              if (isLoggedIn) {
                return const MainScreen();
              } else {
                return const SelectRoleScreen();
              }
            } else {
              return const SelectRoleScreen();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      UserFirebase userFirebase = UserFirebase();
      UserModel? user = await userFirebase.getUser();
      if (user != null) {
        AppState.setUser(user);
      }
    }

    return isLoggedIn;
  }
}
