import 'package:flutter/material.dart';
import 'package:contact_app/contact/contact_home_screen.dart';
import 'package:contact_app/contact/contact_splash_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {"contact_home_screen": (context) => ContactHomeScreen()},
      theme: ThemeData(),
      home: ContactSplashScreen(),
    );
  }
}
