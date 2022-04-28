import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final String label;
  final String place;
  final Function onChange;
  final TextEditingController controller;

  const TextArea({
    Key? key,
    required this.label,
    required this.place,
    required this.onChange,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: place == 'password' || place == 'password2' ? true : false,
      onSaved: (_) {
        onChange;
      },
      onChanged: (_) {
        onChange;
      },
      keyboardType: place == 'phNumber'
          ? TextInputType.number
          : place == 'email'
              ? TextInputType.emailAddress
              : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (place == 'name') {
          if (value!.length < 3) {
            return "Enter correct name";
          } else {
            return null;
          }
        } else if (place == 'phNumber') {
          if (value!.length != 10) {
            return "Enter correct number";
          } else {
            return null;
          }
        } else if (place == 'email') {
          if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!)) {
            return null;
          } else {
            return "Enter correct email";
          }
        } else if (place == 'password') {
          if (value!.length < 8) {
            return "Enter atleast 8 character";
          } else {
            return null;
          }
        }
        return null;
      },
    );
  }
}
