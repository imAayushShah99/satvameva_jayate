import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPress;
  final Color buttonColor;

  const Button(
      {Key? key,
      required this.title,
      required this.onPress,
      required this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPress();
      },
      // (){onPress;}
      child: Text(title),
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        primary: Colors.white,
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
