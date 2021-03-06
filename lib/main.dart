import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/business%20logic/internet cubit/internet_cubit.dart';
import 'package:testing_application/business%20logic/usersList/usersList_cubit.dart';
import 'package:testing_application/data/data%20providers/authAPI.dart';
import 'package:testing_application/data/data%20providers/databaseAPI.dart';
import 'package:testing_application/data/reposetory/authReposetory.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:testing_application/data/reposetory/databaseReposetory.dart';
import 'package:testing_application/presentation%20layer/animations/routeAnimations.dart';
import 'package:testing_application/presentation%20layer/screens/authentication%20screen/authLogin.dart';
import 'package:testing_application/presentation%20layer/screens/authentication%20screen/registerScreen.dart';
import 'package:testing_application/presentation%20layer/screens/chat_screen.dart';
import 'package:testing_application/presentation%20layer/screens/settings_screen.dart';
import 'package:testing_application/presentation%20layer/widgets/monitoringAuth.dart';

import 'business logic/user chat/userchat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    AuthAPI authAPI = AuthAPI();
    AuthReposetory authReposetory = AuthReposetory(authAPI);
    DatabaseAPI databaseAPI = DatabaseAPI();
    DatabaseReposetory databaseReposetory = DatabaseReposetory(databaseAPI);

    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
            authReposetory: authReposetory,
            databaseReposetory: databaseReposetory,
          ),
        ),
        BlocProvider<UsersListCubit>(
          create: (context) => UsersListCubit(databaseReposetory),
        ),
        BlocProvider<UserChatCubit>(
          create: (context) => UserChatCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Testing',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
        ),
        home: MonitoringAuth(),
        routes: {
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          AuthRegister.routeName: (ctx) => AuthRegister(),
          AuthLogin.routeName: (ctx) => AuthLogin(),
        },
      ),
    );
  }
}
