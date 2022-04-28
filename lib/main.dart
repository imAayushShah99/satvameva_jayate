import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:satvameva_jayate/Screens/on_login.dart';
import 'package:satvameva_jayate/Screens/splash.dart';

import 'Screens/home_page.dart';
import 'Screens/display_page.dart';
import 'Screens/on_sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // appBarTheme: AppBarTheme(),
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.ptSerifTextTheme(),
        // buttonTheme: ButtonThemeData(buttonColor: Colors.yellow[900]),
        scaffoldBackgroundColor: Colors.yellow[100],
      ),
      //  ThemeData(
      //   backgroundColor: Colors.yellow[900],
      // ),
      title: 'Sattwa Mev Jayate',
      routes: {
        '/': (context) => const Splash(),
        '/splash': (context) => const Splash(),
        '/displayPage': (context) => const DisplayPage(),
        '/onSignUp': (context) => const OnSignUp(),
        '/onLogin': (context) => const OnLogin(),
        '/homePage': (context) => const HomePage(),
      },
    );
  }
}
