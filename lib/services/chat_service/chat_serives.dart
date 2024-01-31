import 'package:chat_app_with_m/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  // get instanse of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String reciverID, message) async {
    //get user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      SenderID: currentUserID,
      SenderEmail: currentUserEmail,
      reciverID: reciverID,
      message: message,
      timestamp: timestamp,
    );
    //constructer for chat room
    List<String> ids = [currentUserID, currentUserEmail];
    ids.sort();
    String chatRoomID = ids.join('_');
    //add new message to databse
    await _firestore
        .collection("ChatRoom")
        .doc(chatRoomID)
        .collection("Messages")
        .add(newMessage.toMap());
  }
  // get message
  Stream<QuerySnapshot> getMessages(String userID,otherUserID){

    List<String> ids = [userID,otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
    .collection("ChatRoom")
    .doc(chatRoomID)
    .collection("Messages")
    .orderBy("Timestamp",descending: false)
    .snapshots();
  }
}
