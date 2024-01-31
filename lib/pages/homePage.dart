// ignore_for_file: file_names

import 'package:chat_app_with_m/components/user_tile.dart';
import 'package:chat_app_with_m/pages/chat_page.dart';
import 'package:chat_app_with_m/services/auth_service/auth_service.dart';
import 'package:chat_app_with_m/services/chat_service/chat_serives.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();
  final ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        drawer: const MYdraw(Colors.white),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade500,
          title: const Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: _buildUserList(),
      ),
    );
  }

  // Widget _buildUserList() {
  //   return StreamBuilder(
  //     stream: _chatServices.getUserStream(),
  //     builder: ((context, snapshot) {
  //       //error
  //       if (snapshot.hasError) {
  //         return const Text("Error");
  //       }
  //       //loading...
  //       if (ConnectionState.done == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       //return list view
  //       return ListView(
  //         children: snapshot.data!.map<Widget>((userdata)
  //           => _buildUserItemList(userdata,context))
  //             .toList(),
  //       );
  //     }),
  //   );
  // }
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // return list view
        return ListView(
          children: (snapshot.data as List)
              .map<Widget>((userdata) => _buildUserItemList(userdata, context))
              .toList(),
        );
      },
    );
  }

  // Widget _buildUserItemList(
  //     Map<String, dynamic> userdata, BuildContext context) {
  //       //display all users
  //   if(userdata["email"] != _authService.getCurrentUser()!.email){
  //     return UserTile(
  //     text: userdata["email"],
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ChatPage(
  //               reciverEmail: userdata ["email"],
  //             ),
  //           ));
  //     },
  //   );
  //   }else{
  //     return Container();
  //   }
  // }
  Widget _buildUserItemList(
      Map<String, dynamic> userdata, BuildContext context) {
    // display all users
    if (userdata["email"] != null &&
        userdata["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userdata["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                reciverEmail: userdata["email"], reciverID: userdata["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
