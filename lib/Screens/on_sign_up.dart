import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Services/shared_preferences.dart';
import '../button.dart';
import '../text_area.dart';

class OnSignUp extends StatefulWidget {
  const OnSignUp({Key? key}) : super(key: key);

  @override
  State<OnSignUp> createState() => _OnSignUpState();
}

class _OnSignUpState extends State<OnSignUp> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name1 = TextEditingController();
  TextEditingController ph1 = TextEditingController();
  TextEditingController conpas1 = TextEditingController();
  TextEditingController pas1 = TextEditingController();
  TextEditingController em1 = TextEditingController();

  PrefServices prefService = PrefServices();

  String name = '',
      phoneNumber = '',
      email = '',
      password = '',
      confirmPassword = '';

  Future register() async {
    print('I am in reg');
    if (pas1.text != conpas1.text) {
      print('I am in wrong pass');
      Fluttertoast.showToast(
          msg: "Password doesnt match",
          fontSize: 15,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      print('I am in right pass');
      // var url = 'localhost:3000/connect/login.php';
      var response =
          await http.post(Uri.http('fenil.in', '/satva/register.php'), body: {
        'name': name1.text,
        'phNumber': ph1.text,
        'email': em1.text,
        'password': pas1.text,
      });

      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        print(response.headers);
        if (response.body == 'Success found') {
          Fluttertoast.showToast(
              msg: "Successfully Registered",
              fontSize: 15,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT);
          await prefService.createCache(em1.text, pas1.text);
          Navigator.of(context).pushNamed('/homePage', arguments: {
            "name": name1.text,
          });
        } else if (response.body == 'Already Registered') {
          Fluttertoast.showToast(
              msg: "You have already registered, Kindly Login",
              fontSize: 15,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT);
        } else {
          print(response.body);
          Fluttertoast.showToast(
              msg: "Registration Failed",
              fontSize: 15,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT);
        }
      } else {
        print(response.statusCode);
        print(response.body);
        print("I am in else");
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
              'Registration',
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
                          controller: name1,
                          label: 'Name',
                          place: 'name',
                          onChange: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextArea(
                          controller: ph1,
                          label: 'Phone number',
                          onChange: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          place: 'phNumber',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextArea(
                          controller: em1,
                          label: 'Email id',
                          onChange: (value) {
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
                          controller: pas1,
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
                        TextArea(
                          controller: conpas1,
                          label: 'Confirm password',
                          onChange: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          },
                          place: 'password2',
                        ),
                      ],
                    ),
                  ),
                  Button(
                    title: 'NEXT',
                    buttonColor: Colors.amberAccent,
                    onPress: () {
                      print('Pressed');
                      // confirmPassword != password
                      //     ? Fluttertoast.showToast(msg: "Password doesnt match")
                      //     : null;
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                        print('formkey valid');
                        formKey.currentState!.save();
                        register();
                      }
                      //   print(name + ' ' + phoneNumber);
                    },
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
