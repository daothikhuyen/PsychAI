import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/core/models/test_result_model.dart';

class TestConclusionScreen extends StatelessWidget {
  const TestConclusionScreen({required this.result, super.key});

  final TestResult result;

  void _returnToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  Widget _buildScoreLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _buildScoreValue(int score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$score',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 26,
          color: primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => _returnToHome(context),
              icon: const Icon(Icons.home, color: primaryColor, size: 28),
            ),
          ),
        ],
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
                          result.predictedEmotion,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                        _buildScoreLabel('Trầm cảm:'),
                        const SizedBox(),
                        _buildScoreValue(result.depressionScore),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildScoreLabel('Lo lắng:'),
                        const SizedBox(),
                        _buildScoreValue(result.anxietyScore),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildScoreLabel('Căng thẳng:'),
                        const SizedBox(),
                        _buildScoreValue(result.stressScore),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                Center(
                  child: Text(
                    result.conclusion,
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
                    onTap: () => _returnToHome(context),
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

                const Text(
                  'Thông tin liên lạc',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/doctor.jpg'),
                  ),
                  title: const Text(
                    'Bác sĩ Kim',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: const Text(
                    '0988 776655',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_android,
                      color: Colors.black54,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


