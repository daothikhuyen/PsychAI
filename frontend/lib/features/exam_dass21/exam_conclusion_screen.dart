import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/exam_dass21/widget/info_doctor.dart';
import 'package:frontend/features/exam_dass21/widget/score_label.dart';
import 'package:frontend/features/exam_dass21/widget/score_value.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';

class ExamConclusionScreen extends StatelessWidget {
  const ExamConclusionScreen({
    required this.result,
    required this.finalEmotion,
    super.key,
  });

  final Map<String, dynamic> result;
  final String finalEmotion;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> score = result['score'];
    final conclusion = result['result_test'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả Bài test Dass-21'),
        titleTextStyle: const TextStyle(
          color: primaryColor,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/thanks.gif',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 10),

                // Cảm xúc dự đoán
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Cảm xúc dự đoán:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          finalEmotion,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Text(
                  'Kết quả bài test:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FixedColumnWidth(10),
                    2: FlexColumnWidth(),
                  },
                  children: <TableRow>[
                    TableRow(
                      children: [
                        const ScoreLabel(label: 'Trầm cảm:'),
                        const SizedBox(),
                        ScoreValue(score: score['depression']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const ScoreLabel(label: 'Lo lắng:'),
                        const SizedBox(),
                        ScoreValue(score: score['anxiety']),
                      ],
                    ),
                    TableRow(
                      children: [
                        const ScoreLabel(label: 'Căng thẳng:'),
                        const SizedBox(),
                        ScoreValue(score: score['stress']),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                Center(
                  child: Text(
                    conclusion,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 174, 50, 8),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => context.go(PageRoutes.homePage),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Text(
                        'Trang chủ -->',
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                // infomation for doctor
                const InfoDoctor(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
