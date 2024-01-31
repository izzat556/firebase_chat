import 'package:flutter/material.dart';

class MYButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const MYButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.black
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          )
        ),
      ),
    );
  }
}