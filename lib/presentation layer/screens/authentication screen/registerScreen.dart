import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/business%20logic/internet%20cubit/internet_cubit.dart';
import 'package:regexpattern/regexpattern.dart' as reg;
import 'package:testing_application/presentation%20layer/screens/authentication%20screen/authLogin.dart';

class AuthRegister extends StatelessWidget {
  static const routeName = '/register_screen';

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> userData = {
    'email': '',
    'password': '',
    'nickname': '',
    'phoneNumber': '',
    'photoUrl': null,
  };

  void fetchData() {
    bool isDataValid = _formKey.currentState.validate();

    if (isDataValid) {
      _formKey.currentState.save();
      print(userData);
    }
  }

  void takeImage(BuildContext context) async {
    userData['photoUrl'] =
        await BlocProvider.of<AuthenticationCubit>(context).takeImage();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<InternetCubit, InternetState>(
      listener: (_, state) {},
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Register screen'),
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
                  ClipOval(
                    child: FlatButton(
                      onPressed: () => takeImage(context),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: userData['photoUrl'] == null
                                ? AssetImage(
                                    'assets/images/profile.jpg',
                                  )
                                : FileImage(userData['userPhoto']),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      userData['email'] = newValue;
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
                      userData['password'] = newValue;
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value.trim().length < 3) {
                        return 'Please enter a username that is longer than 3 characters.';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      userData['nickname'] = newValue;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (reg.RegVal.hasMatch(value, reg.RegexPattern.phone)) {
                        return null;
                      } else {
                        return 'Please enter a valid phone Number';
                      }
                    },
                    onSaved: (newValue) {
                      userData['phoneNumber'] = newValue;
                    },
                  ),
                  RaisedButton(
                    onPressed: fetchData,
                    child: Text('Register'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Text('I allready have an account'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AuthLogin.routeName);
                    },
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
