import 'package:flutter/material.dart';
import 'views/can_cup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAN 2023',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // appBarTheme: AppBarTheme(
        //   iconTheme: IconThemeData(color: Colors.white),
        //   // color: Colors.white, //<-- SEE HERE
        // ),
      ),
      debugShowCheckedModeBanner: false,
      home: const CanCup(),
    );
  }
}
