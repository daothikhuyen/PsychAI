import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/home/widget/card_text_item.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  // ignore: avoid_field_initializers_in_const_classes
  final List<Map<String, dynamic>> testResults = const [
    {
      'id': 1,
      'date': '16-08-2025',
      'emotion': 'Ngạc nhiên',
      'emotionEmoji': '😍',
    },
    // ignore: lines_longer_than_80_chars
    {
      'id': 2,
      'date': '20-08-2025',
      'emotion': 'Tức giận',
      'emotionEmoji': '😭',
    },
    {'id': 3, 'date': '28-08-2025', 'emotion': 'Buồn', 'emotionEmoji': '😔'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: infoCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/heart_1.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    'Chúng tôi ở đây, để lắng nghe trái tim bạn',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            'Các bài kiểm tra',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B5B84),
            ),
          ),
          const SizedBox(height: 15),

          ...testResults.map((result) {
            return const CardTextItem();
          }),
        ],
      ),
    );
  }
}
