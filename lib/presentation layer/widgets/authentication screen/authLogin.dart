import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart' as reg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';

class AuthLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  var scaffoldKey;

  AuthLogin({this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
