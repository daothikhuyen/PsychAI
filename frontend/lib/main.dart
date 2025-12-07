import 'package:flutter/material.dart';
import 'package:frontend/features/news/news_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Public Feed UI',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewsScreen(), 
    );
  }
}
