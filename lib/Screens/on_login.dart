import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Services/shared_preferences.dart';
import '../button.dart';
import '../text_area.dart';

class OnLogin extends StatefulWidget {
  const OnLogin({Key? key}) : super(key: key);

  @override
  State<OnLogin> createState() => _OnLoginState();
}

class _OnLoginState extends State<OnLogin> {
  final formKey = GlobalKey<FormState>();
  String email = '', password = '';
  var userName;
  var myName;

  TextEditingController emailid = TextEditingController();
  TextEditingController pas = TextEditingController();

  PrefServices prefService = PrefServices();

  Future login() async {
    if (emailid.text == "" || pas.text == "") {
      Fluttertoast.showToast(
          msg: "Enter something",
          fontSize: 15,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      // var url = 'localhost:3000/connect/login.php';
      var response =
          await http.post(Uri.http('fenil.in', '/satva/login.php'), body: {
        'email': emailid.text,
        'password': pas.text,
      });

      if (response.statusCode == 200) {
        userName = json.decode(response.body);
        if (userName['result'] == 'success') {
          print(response);
          myName = userName['name'];
          print(myName);
          // final result =
          //     await http.get(Uri.http('fenil.in', '/satva/login.php'));
          // if (result.statusCode == 200) {
          //   print(result);

          // }
          Fluttertoast.showToast(
              msg: "Successfully LoggedIn",
              fontSize: 15,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT);
          await prefService.createCache(myName, pas.text);
          Navigator.of(context)
              .pushNamed('/homePage', arguments: {'name': myName});
        } else {
          print(response);
          Fluttertoast.showToast(
              msg: "Details doesnt match",
              fontSize: 15,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT);
        }
      
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: 1,
                child: Image.asset(
                  'assets/Meditation_Practice-modified.png',
                ),
              ),
            ),
            title: const Text(
              'Log In',
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SvgPicture.asset(
                  //   'images/logo.svg', alignment: Alignment.topLeft,
                  //   // fit: BoxFit.,
                  //   height: 60,
                  // ),
                  // Text('Logo'),

                  // Image.asset('assets/images/logo.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextArea(
                          controller: emailid,
                          label: 'Email id',
                          onChange: (value) {
                            Fluttertoast.showToast(msg: 'Hello');
                            setState(() {
                              email = value;
                            });
                          },
                          place: 'email',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextArea(
                          controller: pas,
                          label: 'Password',
                          onChange: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          place: 'password',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Button(
                      title: 'NEXT',
                      buttonColor: Colors.amberAccent,
                      onPress: () {
                        login();
                        // confirmPassword != password
                        //     ? Fluttertoast.showToast(msg: "Password doesnt match")
                        //     : null;
                        // final isValid = formKey.currentState!.validate();
                        // if (isValid) {
                        //   formKey.currentState!.save();

                        // print(name + ' ' + phoneNumber);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
