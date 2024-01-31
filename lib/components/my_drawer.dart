import 'package:chat_app_with_m/pages/settings.dart';
import 'package:chat_app_with_m/services/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MYdraw extends StatelessWidget {
  const MYdraw(Color white, {super.key});

  //logout
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "HOME",
                style: TextStyle(color: Colors.black),
              ),
              leading: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "SETTINGS",
                style: TextStyle(color: Colors.black),
              ),
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SETTINGS()));
              },
            ),
          ),
          const SizedBox(
            height: 480,
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 25),
              child: ListTile(
                title: const Text(
                  "LOG OUT",
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ))
        ],
      ),
    );
  }
}
