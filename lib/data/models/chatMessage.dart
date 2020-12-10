import 'package:cloud_firestore/cloud_firestore.dart' as fbcloud;

class Message {
  final String msg;
  final fbcloud.Timestamp sentOn;
  final String senderId;
  final String recieverId;
  final String messageId;

  const Message({
    this.msg,
    this.messageId,
    this.recieverId,
    this.senderId,
    this.sentOn,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      msg: message['msg'],
      messageId: message['messageId'],
      recieverId: message['recieverId'],
      senderId: message['senderId'],
      sentOn: message['sentOn'],
    );
  }
}
