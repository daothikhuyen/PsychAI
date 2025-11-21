import 'package:flutter/material.dart';
import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final authController = context.watch<AuthController>();
    final user = authController.currentUser;

    return Scaffold( 
      appBar: AppBar(
        title: const Text('Trang Chủ'), // Thêm AppBar vào đây!
      ),
      body: Center(
        child: Text(
          user?.displayName??'',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
