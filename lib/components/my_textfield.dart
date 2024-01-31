import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscuretext;
  const MyTextfield({super.key, required this.hinttext, required this.obscuretext, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscuretext,
      controller:  controller,
      decoration: InputDecoration(
        enabledBorder:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ) ,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        filled: true,
        fillColor: Colors.grey.shade300,
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}