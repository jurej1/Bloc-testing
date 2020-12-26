import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:image_picker/image_picker.dart' as img;
import 'dart:io';

//Reposetory
import 'package:testing_application/data/reposetory/authReposetory.dart';

//Models
import 'package:testing_application/data/models/user.dart' as app;
import 'package:testing_application/data/reposetory/databaseReposetory.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthReposetory authReposetory;
  final DatabaseReposetory databaseReposetory;

  AuthenticationCubit({
    this.authReposetory,
    this.databaseReposetory,
  }) : super(LoadingState()) {
    checkIfTheUserIsLoggedIn();
  }

  Future<void> checkIfTheUserIsLoggedIn() async {
    app.User user = await authReposetory.checkUser();

    if (user == null) {
      emit(UserLogedOut());
    } else {
      emit(UserLogedIn(user));
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoadingState());
    try {
      app.User userData = await authReposetory.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(UserLogedIn(userData));
    } catch (error) {
      print('Authentication cubit error:');
      print(error);

      emit(ErrorWhileAuthentication(error));
    }
  }

  Future<void> logoutUser() async {
    emit(LoadingState());
    await authReposetory.logoutUser();

    emit(UserLogedOut());
  }

  Future<File> takeImage() async {
    img.PickedFile pickedFile = await img.ImagePicker.platform.pickImage(
      source: img.ImageSource.camera,
    );

    File image = File(pickedFile.path);

    return image;
  }
}
