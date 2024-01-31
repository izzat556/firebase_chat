import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String SenderID;
  final String SenderEmail;
  final String reciverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.SenderID,
      required this.SenderEmail,
      required this.reciverID,
      required this.message,
      required this.timestamp});

      //convert to a map

      Map<String,dynamic> toMap(){
        return {
          'senderID': SenderID,
          'senderEmail':SenderEmail,
          'reciverID': reciverID,
          'message': message,
          'timestamp':timestamp,
        };
      }
}
