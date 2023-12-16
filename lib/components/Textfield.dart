import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField(
      {super.key,
      required this.hinttext,
      required this.iconn,
      required this.textEditingController});
  final String hinttext;
  final IconData iconn;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: hinttext,
          icon: Icon(iconn),
        ),
        controller: textEditingController,
      ),
    );
  }
}
