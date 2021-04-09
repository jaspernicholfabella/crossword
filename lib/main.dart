import 'package:flutter/material.dart';
import'./screens/home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crossword Puzzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: Container(
        child:HomeScreen(),
        )
    );
  }
}
