import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const UserTile({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12)
        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            //Icon
            const Icon(Icons.person),
            //Text
            Text(text,style: const TextStyle(color: Colors.black),),
          ],
        ),
      ),
    );
  }
}