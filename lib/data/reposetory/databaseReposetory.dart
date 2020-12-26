import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_application/data/data%20providers/databaseAPI.dart';
import 'dart:io';

import '../models/user.dart' as app;

class DatabaseReposetory {
  DatabaseReposetory(DatabaseAPI data) {
    _databaseAPI = data;
  }
  DatabaseAPI _databaseAPI;

  List<app.User> _transformUserFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return app.User.fromJson(doc.data());
    }).toList();
  }

  Stream<List<app.User>> get usersListSnapshot {
    return _databaseAPI.usersSnapshot.map(_transformUserFromQuerySnapshot);
  }

  // Stream<QuerySnapshot> userChats(String chatId) {}

  Future<String> uploadImage(File file, String uid) async {
    String downloadUrl = await _databaseAPI.uploadImage(
      file,
      uid,
    );

    return downloadUrl;
  }
}
