// ignore_for_file: prefer_const_constructors

import 'package:dermaclinic_patients_fyp_20048674/routes/login.dart';
import 'package:flutter/material.dart';

import 'routes/home.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (context) => const HomePage(),
        'login': (context) => const LoginPage(),
      },
      title: 'Appointment App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xff0D1B34),
          ),
          headline2: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff0D1B34)),
          headline5: TextStyle(fontSize: 14, color: Color(0xff8696BB)),
          headline4: TextStyle(
              color: Color(0xff4894FE),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          button: TextStyle(
            color: Color(0xff4894FE),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          headline3: TextStyle(color: Color(0xff8696BB), fontSize: 16),
          bodyText2: TextStyle(color: Color(0xff8696BB), fontSize: 12),
        ),
      ),
      home: LoginPage(),
    );
  }
}
