import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as app;

import '../data providers/authAPI.dart';

class AuthReposetory {
  AuthAPI authApi;

  AuthReposetory(this.authApi);

  Future<app.User> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      UserCredential userCredential = await authApi.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userData = await authApi.getUserDataFromFirebase(
        userId: userCredential.user.uid,
      );

      app.User user = app.User.fromDocSnapshot(userData);

      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<app.User> checkUser() async {
    User firebaseUser = authApi.checkIfUserIsSignedIn();

    if (firebaseUser == null) {
      return null;
    } else {
      DocumentSnapshot userData = await authApi.getUserDataFromFirebase(
        userId: firebaseUser.uid,
      );

      app.User user = app.User.fromDocSnapshot(userData);
      return user;
    }
  }

  Future<void> logoutUser() async {
    await authApi.signOut();
  }

  Future<app.User> createUserWithEmailAndPassword({
    Map<String, String> userData,
  }) async {
    try {
      UserCredential userCredential =
          await authApi.createUserWithEmailAndPassword(
        email: userData['email'],
        password: userData['password'],
      );

      await authApi.createUserDataInFirebase(
        email: userData['email'],
        nickname: userData['nickname'],
        phoneNumber: userData['phoneNumber'],
        uid: userCredential.user.uid,
        photoUrl: userData['photoUrl'] ??
            'https://djraphaelschlosser.de/wp-content/uploads/2017/09/profile.jpg',
      );

      DocumentSnapshot userFirebase = await authApi.getUserDataFromFirebase(
          userId: userCredential.user.uid);

      app.User user = app.User.fromDocSnapshot(userFirebase);

      return user;
    } catch (e) {
      throw e;
    }
  }
}
