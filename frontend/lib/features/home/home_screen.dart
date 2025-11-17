import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 Thêm Scaffold vào màn hình con
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Trang Chủ'), // Thêm AppBar vào đây!
      ),
      body: const Center(
        child: Text(
          'Đây là nội dung của Home Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
