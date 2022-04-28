import 'package:flutter/material.dart';

import '../button.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            'Sattwa Mev Jayate',
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/Homeicon-modified.png'),
              Column(
                children: [
                  Button(
                    title: 'Sign Up',
                    buttonColor: Colors.amberAccent,
                    onPress: () {
                      Navigator.of(context).pushNamed('/onSignUp');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    buttonColor: Colors.amberAccent,
                    onPress: () {
                      Navigator.of(context).pushNamed('/onLogin');
                    },
                    title: 'Login',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
