// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:chat_app_with_m/components/my_button.dart';
import 'package:chat_app_with_m/components/my_textfield.dart';
import 'package:chat_app_with_m/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap,});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

void SignIN(BuildContext context)async{
  //auth service
  final authservice = AuthService();
  // get sign in
  try{
    await authservice.signInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
  }
  //catch errors
  catch(e){
    showDialog(
    context: context, 
    builder: (context)=>AlertDialog(
      title: Text(e.toString()),
    ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
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
                    height: 25,
                  ),
                   MYButton(
                    text: "Sign in",
                    onTap: () => SignIN(context),
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
                          "Register here!",
                          style: TextStyle(
                              color: Colors.black, 
                              fontWeight: FontWeight.bold
                          ),
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
