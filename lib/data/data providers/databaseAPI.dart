import 'package:cloud_firestore/cloud_firestore.dart' as fbcloud;

class DatabaseAPI {
  final dbCloud = fbcloud.FirebaseFirestore.instance;

  Stream<fbcloud.QuerySnapshot> get usersSnapshot {
    return dbCloud.collection('users').snapshots();
  }

  Stream<fbcloud.QuerySnapshot> chat(String chatId) {
    return dbCloud
        .collection('chats')
        .doc(chatId)
        .collection('chat')
        .snapshots();
  }
}
