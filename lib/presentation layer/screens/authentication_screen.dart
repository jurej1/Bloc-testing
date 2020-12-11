import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/presentation%20layer/screens/authentication%20screen/registerScreen.dart';

import 'authentication screen/authLoading.dart';
import 'authentication screen/authLogin.dart';

// ignore: must_be_immutable
class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (_, state) {
        if (state is LoadingState) {
          return LoadingScreen();
        } else {
          return AuthLogin();
        }
      },
    );
  }
}
