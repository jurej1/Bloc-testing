import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:regexpattern/regexpattern.dart' as reg;
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/business%20logic/internet%20cubit/internet_cubit.dart';
import 'package:testing_application/presentation%20layer/helpers/auth_snackBar.dart';
import '../helpers/internet_SnackBar.dart';

class AuthenticationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocListener(
      listeners: [
        BlocListener<InternetCubit, InternetState>(
          listener: (_, state) {
            internetSnackBar(
              scaffoldKey: _scaffoldKey,
              state: state,
            );
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (_, state) {
            if (state is ErrorWhileAuthentication) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(state.errorMsg),
                ),
              );
            }
          },
        )
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Authentication'),
          centerTitle: true,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (reg.RegVal.hasMatch(value, reg.RegexPattern.email)) {
                        return null;
                      } else {
                        return 'Please enter a valid email';
                      }
                    },
                    onSaved: (newValue) {
                      email = newValue;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.trim().length > 6) {
                        return null;
                      } else {
                        return 'Please enter a valid password';
                      }
                    },
                    onSaved: (newValue) {
                      password = newValue;
                    },
                  ),
                  RaisedButton(
                    onPressed: () async {
                      bool userInputCorrect = _formKey.currentState.validate();

                      if (userInputCorrect) {
                        _formKey.currentState.save();

                        print('going into cubit');
                        BlocProvider.of<AuthenticationCubit>(context)
                            .signInWithEmailAndPassword(email, password);
                      }
                    },
                    child:
                        BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (_, state) {
                        if (state is LoadingState) {
                          return CircularProgressIndicator();
                        } else {
                          return Text('Login');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
