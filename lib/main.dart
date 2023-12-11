import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      initialRoute: '/',
      routes: {
        '/': (context) => RegistrationScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
