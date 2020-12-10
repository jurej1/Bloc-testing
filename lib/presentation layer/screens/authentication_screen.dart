import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/business%20logic/internet%20cubit/internet_cubit.dart';
import 'package:testing_application/presentation%20layer/helpers/auth_snackBar.dart';
import 'package:testing_application/presentation%20layer/widgets/authentication%20screen/authLoading.dart';
import 'package:testing_application/presentation%20layer/widgets/authentication%20screen/authLogin.dart';
import '../helpers/internet_SnackBar.dart';

// ignore: must_be_immutable
class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (_, state) {
        internetSnackBar(
          state: state,
        );
      },
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (_, state) {
          if (state is ErrorWhileAuthentication) {
            authSnackBar(
              msg: state.errorMsg,
              context: context,
            );
          }
        },
        builder: (_, state) {
          if (state is UserLogedOut) {
            return AuthLogin();
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}
