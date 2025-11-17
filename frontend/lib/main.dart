import 'package:flutter/material.dart';
import 'package:frontend/core/themes/theme.dart';
import 'package:frontend/routing/routes.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightMode,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
