// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:chat_app_with_m/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class Registerpage extends StatefulWidget {
  final void Function()? onTap;
  const Registerpage({
    super.key,
    this.onTap,
  });

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

final confirmpasswordController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();

void SignUp(BuildContext context) {
  //auth service connecting
  final _auth = AuthService();

 //account created
  if (passwordController.text == confirmpasswordController.text) {
    try {
      _auth.signUPWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }
  //password don't match
  else{
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match"),
        ),
      );
  }
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTextfield(
                    hinttext: 'Email',
                    obscuretext: false,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                    hinttext: "Password",
                    obscuretext: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                    hinttext: "Confirm Password",
                    obscuretext: true,
                    controller: confirmpasswordController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                   MYButton(
                    text: "Sign up",
                    onTap: ()=> SignUp(context),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login here!",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
