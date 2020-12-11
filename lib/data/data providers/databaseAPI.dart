import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' as fbcloud;
import 'package:firebase_storage/firebase_storage.dart' as fbstorage;

class DatabaseAPI {
  final dbCloud = fbcloud.FirebaseFirestore.instance;
  final dbStorage = fbstorage.FirebaseStorage.instance;

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

  Future<String> uploadImage(
    File image,
    String uid,
  ) async {
    fbstorage.Reference ref =
        dbStorage.ref().child('user images').child('$uid.jpg');

    await ref.putFile(image);

    String downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }
}
