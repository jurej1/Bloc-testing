import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_application/data/data%20providers/databaseAPI.dart';
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

  Stream<QuerySnapshot> userChats(String chatId) {}
}
