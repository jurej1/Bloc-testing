import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fbcloud;
import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:google_sign_in/google_sign_in.dart' as google;
import 'package:meta/meta.dart';

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

      throw msg;
    } catch (error) {
      String msg = 'Oops something went wrong';
      throw msg;
    }
  }

  Future<void> createUserDataInFirebase({
  @required  String uid,
  @required  String email,
  @required  String nickname,
  @required  String phoneNumber,
    @required String photoUrl,
  }) async {
    try {
      await dbCloud.collection('users').doc(uid).set({
        'contacts': [],
        'email': email,
        'id': uid,
        'joinedOn': fbcloud.Timestamp.now(),
        'nickname': nickname,
        'phoneNumber': phoneNumber,
        'photoUrl': '',
        'userBio': 'Hey I am using Arrow',
      });
    } catch (e) {
      throw e;
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
      String msg = 'Oops something went wrong';
      throw msg;
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
      }
      if (e.contains('user-disabled')) {
        msg = 'Sorry but you have been disabled.';
      }
      if (e.contains('user-not-found')) {
        msg = 'Sorrry but this user has not been found.';
      }
      if (e.contains('wrong-password')) {
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
