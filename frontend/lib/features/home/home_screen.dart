import 'package:flutter/material.dart';
import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:frontend/features/home/home_main_screen.dart';
import 'package:frontend/features/home/widget/header_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final bool _hasTestResults = true;

  // Widget get _homeScreen {
  //   if (_hasTestResults) {
  //     final mockResult = TestResult(
  //       predictedEmotion: 'Bình thường',
  //       depressionScore: 0,
  //       anxietyScore: 0,
  //       stressScore: 0,
  //       conclusion: 'Chào mừng! Bắt đầu bài test đầu tiên của bạn.',
  //     );

  //     return TestConclusionScreen(result: mockResult);
  //   } else {
  //     return const HomeWelcomeScreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    final user = authController.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(username: user?.displayName, avatarUrl: user?.photoUrl),

      body:  const HomeMainScreen(),
    );
  }
}
