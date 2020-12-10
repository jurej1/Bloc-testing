import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fbcloud;

class User {
  final String email;
  final String id;
  final fbcloud.Timestamp joinedOn;
  final String nickname;
  final String phoneNumber;
  final String photoUrl;
  final String userBio;
  final List<dynamic> contacts;

  User({
    @required this.email,
    @required this.id,
    @required this.joinedOn,
    @required this.nickname,
    this.phoneNumber,
    @required this.photoUrl,
    @required this.userBio,
    @required this.contacts,
  });

  // List<Map<String, String>> _userContacts(List<dynamic> contacts) {
  //   contacts.map((data) {
  //     return {
  //       'chatId': data['chatId'],
  //       'id': data['id'],
  //     };
  //   });
  // }

  factory User.fromJson(Map<String, dynamic> userData) {
    return User(
      email: userData['email'],
      id: userData['id'],
      joinedOn: userData['joinedOn'],
      nickname: userData['nickname'],
      photoUrl: userData['photoUrl'],
      userBio: userData['userBio'],
      phoneNumber: userData['phoneNumber'],
      contacts: userData['contacts'],
    );
  }

  factory User.fromDocSnapshot(fbcloud.DocumentSnapshot userDoc) {
    var userData = userDoc.data();

    return User(
      email: userData['email'],
      id: userData['id'],
      joinedOn: userData['joinedOn'],
      nickname: userData['nickname'],
      photoUrl: userData['photoUrl'],
      userBio: userData['userBio'],
      phoneNumber: userData['phoneNumber'],
      contacts: userData['contacts'],
    );
  }
}
