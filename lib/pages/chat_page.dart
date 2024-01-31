import 'package:chat_app_with_m/components/my_textfield.dart';
import 'package:chat_app_with_m/services/auth_service/auth_service.dart';
import 'package:chat_app_with_m/services/chat_service/chat_serives.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String reciverID;
  ChatPage({
    super.key,
    required this.reciverID,
    required this.reciverEmail,
  });

  final TextEditingController _messageController = TextEditingController();

  final AuthService _authService = AuthService();
  final ChatServices _chatServices = ChatServices();

  //send message
  void sendMessage() async {
    //if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatServices.sendMessage(reciverID, _messageController.text);
      //clear text
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          centerTitle: true,
          title: Text(reciverEmail),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            //user send message button
            _buildUserInput(color: Colors.black),
          ],
        ),
      ),
    );
  }

  //build message list
  // Widget _buildMessageList(){
  //   String senderID = _authService.getCurrentUser()!.uid;
  //   return StreamBuilder(
  //     stream: _chatServices.getMessages(reciverID, senderID),
  //     builder: (context,snapshot){
  //       if(snapshot.hasError) {
  //         return const Text("error");
  //       }

  //       else if(ConnectionState.done == ConnectionState.waiting){
  //         return const Center(child: CircularProgressIndicator(),);
  //       }
  //       else{
  //         return ListView(
  //         children: snapshot.data!.docs.map((doc) =>_buildMessageItem(doc)).toList(),
  //       );
  //       }
        
  //     },
  //   );
  // }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(reciverID, senderID),
      builder: (context, snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return const Center(child: CircularProgressIndicator());
        }
       else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        //   return const Center(child: Text("No messages available"));
        // }

        // return ListView.builder(
        //   itemCount: snapshot.data!.docs.length,
        //   itemBuilder: (context, index) =>
        //       _buildMessageItem(snapshot.data!.docs[index]),
        // );
       else{
         return ListView(
          
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
       }
        
      },
      
    );
    
  }

  //nuild message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data["Messages"]),
          ],
          
        )
        );
        
  }

  //build message input
  Widget _buildUserInput({required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50,left: 10),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              controller: _messageController,
              hinttext: "Send Message",
              obscuretext: false,
            ),
          ),
      
          //send Button
          IconButton(
          onPressed: sendMessage, 
          icon: const Icon(Icons.arrow_right,),
          ),
        ],
      ),
    );
  }
}
