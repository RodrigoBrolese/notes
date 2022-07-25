import 'package:flutter/material.dart';
import 'package:notes/styles/app.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primaryColor: Style.primaryColor,
        scaffoldBackgroundColor: Style.primaryColor,
        navigationBarTheme:
            const NavigationBarThemeData(backgroundColor: Style.primaryColor),
        brightness: Brightness.dark,
        fontFamily: 'Nunito',
      ),
      home: const HomePage(),
    );
  }
}
