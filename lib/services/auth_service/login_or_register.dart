// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names

import 'package:chat_app_with_m/pages/login_page.dart';
import 'package:chat_app_with_m/pages/register_page.dart';
import 'package:flutter/material.dart';

class Show_Login_or_Register extends StatefulWidget {
  const Show_Login_or_Register({super.key});

  @override
  State<Show_Login_or_Register> createState() => _Show_Login_or_RegisterState();
}

class _Show_Login_or_RegisterState extends State<Show_Login_or_Register> {
  bool showLoginPage = true;

  void toggleScreen() {
   setState(() {
      showLoginPage = !showLoginPage;
   });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return  LoginPage(onTap:toggleScreen);
    } else {
      return  Registerpage(onTap:toggleScreen);
    }
  }
}
