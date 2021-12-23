import 'package:flutter/material.dart';
import 'package:todo_sqlite/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite TODO',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.pinkAccent, // foreground
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.pinkAccent, // foreground
          ),
        ),
      ),
    );
  }
}
