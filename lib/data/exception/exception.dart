import 'package:testing_application/data/models/chatMessage.dart';

class Ex implements Exception {
  String message;

  Ex(message);

  @override
  String toString() {
    return message.toString();
  }
}
