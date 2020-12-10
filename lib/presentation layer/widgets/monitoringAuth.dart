import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/presentation%20layer/screens/authentication_screen.dart';
import 'package:testing_application/presentation%20layer/screens/main_screen.dart';

class MonitoringAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is UserLogedIn) {
          return MainScreen();
        } else {
          return AuthenticationScreen();
        }
      },
    );
  }
}
