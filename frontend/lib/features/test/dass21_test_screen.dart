// lib/features/psychological_test/dass21_test_screen.dart

import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
// import 'package:frontend/core/models/test_result_model.dart';
import 'package:frontend/features/home/test_conclusion_screen.dart';
import 'package:frontend/features/test/dass21_calculator.dart';

class Dass21TestScreen extends StatefulWidget {
  const Dass21TestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Dass21TestScreenState createState() => _Dass21TestScreenState();
}

class _Dass21TestScreenState extends State<Dass21TestScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'text': 'Tôi cảm thấy khó trấn tĩnh khi bị kích động',
      'answer': 0,
      'scale': 'S',
    },
    {
      'id': 2,
      'text': 'Tôi không thấy điều gì để trông mong, chờ đợi',
      'answer': 0,
      'scale': 'D',
    },
    {
      'id': 3,
      'text': 'Tôi cảm thấy không có gì là chắc chắn',
      'answer': 0,
      'scale': 'A',
    },
  ];

  final List<String> _options = [
    '0 - Không đúng với tôi chút nào cả',
    '1 - Đúng với tôi phần, hoặc thỉnh thoảng mới đúng',
    '2 - Đúng với tôi phần nhiều, hoặc phần lớn thời gian là đúng',
    '3 - Hoàn toàn đúng với tôi, hoặc hầu hết thời gian là đúng',
  ];

  void _onAnswerSelected(int questionIndex, int value) {
    setState(() {
      _questions[questionIndex]['answer'] = value;
    });
  }

void _onDonePressed() {
    // ignore: omit_local_variable_types
    final bool allAnswered = _questions.every((q) => q['answer'] != 0);
    final result = Dass21Calculator.calculateScores(_questions); 
    if (allAnswered) {
      // Chuyển sang màn hình kết luận
      Navigator.push( // <--- SỬ DỤNG Navigator.push thay vì pushAndRemoveUntil
        context,
        MaterialPageRoute(
          builder: (context) => TestConclusionScreen(result: result),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bạn vui lòng trả lời tất cả các câu hỏi.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Color.fromARGB(255, 120, 120, 120),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bài kiểm tra DASS 21'),
        titleTextStyle: const TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 26,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final question = _questions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3, // Thêm độ nổi cho Card
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Câu ${question['id']}: ${question['text']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      // color: Color(0xFF323F4B),
                      color: primaryColor,
                    ),
                  ),
                  const Divider(height: 24, thickness: 1),
                  ...List.generate(_options.length, (optionIndex) {
                    return RadioListTile<int>(
                      title: Text(
                        _options[optionIndex],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: optionIndex,
                      // ignore: deprecated_member_use
                      groupValue: question['answer'] as int,
                      // ignore: deprecated_member_use
                      onChanged: (int? value) {
                        if (value != null) {
                          _onAnswerSelected(index, value);
                        }
                      },
                      activeColor: const Color(0xFF3B5B84),
                      contentPadding: EdgeInsets.zero, // Xóa padding mặc định
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _onDonePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B5B84),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Hoàn Thành',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
