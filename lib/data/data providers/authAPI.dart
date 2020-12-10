import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:google_sign_in/google_sign_in.dart' as google;
import 'package:cloud_firestore/cloud_firestore.dart' as fbcloud;
import 'dart:async';

import 'package:testing_application/data/exception/exception.dart';

class AuthAPI {
  final dbAuth = fbauth.FirebaseAuth.instance;
  final dbCloud = fbcloud.FirebaseFirestore.instance;

  Future<fbauth.UserCredential> createUserWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      fbauth.UserCredential userCredential =
          await dbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on fbauth.FirebaseAuth catch (error) {
      var e = error.toString();
      String msg = 'Oops something went wrong';

      if (e.contains('email-already-in-use')) {
        msg = 'Email allready exists';
      } else if (e.contains('invalid-email')) {
        msg = 'Email address is not valid';
      } else if (e.contains('weak-password')) {
        msg = 'Weak password';
      }

      throw Ex(msg);
    } catch (error) {
      String msg = 'Oops something went wrong';
      throw Ex(msg);
    }
  }

  Future<fbcloud.DocumentSnapshot> getUserDataFromFirebase({
    String userId,
  }) async {
    try {
      fbcloud.DocumentSnapshot userData =
          await dbCloud.collection('users').doc(userId).get();

      return userData;
    } catch (e) {
      throw Ex('Oops something went wrong');
    }
  }

  Future<fbauth.UserCredential> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      fbauth.UserCredential userCredential =
          await dbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on fbauth.FirebaseAuthException catch (error) {
      var e = error.toString();
      String msg = 'Oops something went wrong';

      if (e.contains('invalid-email')) {
        msg = 'Invalid email';
      } else if (e.contains('user-disabled')) {
        msg = 'Sorry but you have been disabled.';
      } else if (e.contains('user-not-found')) {
        msg = 'Sorrry but this user has not been found.';
      } else if (e.contains('wrong-password')) {
        msg = 'Invalid password';
      }

      throw msg;
    } catch (error) {
      String msg = 'Oops something went wrong';
      throw msg;
    }
  }

  fbauth.User checkIfUserIsSignedIn() {
    return dbAuth.currentUser;
  }

  Future<fbauth.UserCredential> googleSignIn() async {
    google.GoogleSignInAccount googleSignInAccount =
        await google.GoogleSignIn.standard().signIn();

    fbauth.UserCredential userCredential;

    if (googleSignInAccount == null) {
      return userCredential;
    }

    google.GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    fbauth.OAuthCredential credential = fbauth.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    userCredential = await dbAuth.signInWithCredential(
      credential,
    );

    return userCredential;
  }

  Future<void> signOut() async {
    await dbAuth.signOut();
  }
}
