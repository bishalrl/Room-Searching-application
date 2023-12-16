import 'package:flutter/material.dart';

class ButtonB extends StatelessWidget {
  const ButtonB(
      {super.key,
      required this.nameofbutton,
      required this.ontap,
      required this.colorofbutton,
      required this.heightofbutton,
      required this.widthofbutton});
  final String nameofbutton;
  final double heightofbutton;
  final double widthofbutton;
  final VoidCallback ontap;
  final Color colorofbutton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: heightofbutton,
        width: widthofbutton,
        decoration: BoxDecoration(
            color: colorofbutton, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(nameofbutton)),
      ),
    );
  }
}
