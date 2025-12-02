import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/core/models/test_result_model.dart';
// import 'package:frontend/features/home/main_screen.dart'; 

class TestConclusionScreen extends StatelessWidget {
  const TestConclusionScreen({
    super.key,
    // ignore: always_put_required_named_parameters_first
    required this.result,
  });

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
        label, style: const TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.normal)),
    );
  }

  Widget _buildScoreValue(int score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text('$score', 
      style: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
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
                        fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: <Widget>[
                        Text(
                          result.predictedEmotion,
                          style: const TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.normal),
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
                     2: FlexColumnWidth()},
                  children: <TableRow>[
                    TableRow(children: [
                      _buildScoreLabel('Trầm cảm:'),
                      const SizedBox(),
                      _buildScoreValue(result.depressionScore),
                    ]),
                    TableRow(children: [
                      _buildScoreLabel('Lo lắng:'),
                      const SizedBox(),
                      _buildScoreValue(result.anxietyScore),
                    ]),
                    TableRow(children: [
                      _buildScoreLabel('Căng thẳng:'),
                      const SizedBox(),
                      _buildScoreValue(result.stressScore),
                    ]),
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
                      fontSize: 20)),
                  subtitle: const Text('0988 776655', style: TextStyle(
                    color: Colors.black87, 
                    fontWeight: FontWeight.normal, 
                    fontSize: 20)),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_android, 
                      color: Colors.black54, size: 28),
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

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  // ignore: avoid_field_initializers_in_const_classes
  final List<Map<String, dynamic>> testResults = const [
    {'id': 1, 'date': '16-08-2025', 'emotion': 'Ngạc nhiên', 'emotionEmoji': '😍'},
    // ignore: lines_longer_than_80_chars
    {'id': 2, 'date': '20-08-2025', 'emotion': 'Tức giận', 'emotionEmoji': '😭'},
    {'id': 3, 'date': '28-08-2025', 'emotion': 'Buồn', 'emotionEmoji': '😔'},
  ];
  
  Widget _buildWelcomeBanner() {
    return Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: BoxDecoration(
              color: infoCardColor,
              borderRadius: BorderRadius.circular(20),
             ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/heart_1.png',
                    // color: PrimaryColor,
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 15),

                const Expanded(
                  child: Text(
                    // ignore: lines_longer_than_80_chars
                    'Chúng tôi ở đây,để lắng nghe trái tim bạn',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ], 
            ),
    );
  }

  Color _getEmojiColor(String emoji) {
  switch (emoji) {
    // ignore: deprecated_member_use
    case '😍': return Colors.green.shade400.withOpacity(0.8);
    // ignore: deprecated_member_use
    case '😭': return Colors.red.shade400.withOpacity(0.8);
    // ignore: deprecated_member_use
    case '😔': return Colors.grey.shade500.withOpacity(0.8);
    // ignore: deprecated_member_use
    case '😊': return Colors.pink.shade400.withOpacity(0.8);
    // ignore: deprecated_member_use
    case '👍': return Colors.orange.shade400.withOpacity(0.8);
    // ignore: deprecated_member_use
    case '😡': return Colors.deepPurple.shade400.withOpacity(0.8);
    // ignore: deprecated_member_use
    default: return Colors.blue.shade400.withOpacity(0.8);
  }
}

  Widget _buildResultCard(BuildContext context, Map<String, dynamic> result) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        // ignore: avoid_redundant_argument_values
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: InkWell(
        onTap: () {
          // Chuyển đến trang kết quả chi tiết
          Navigator.push(
            context,
            MaterialPageRoute(
              // ignore: lines_longer_than_80_chars
              builder: (context) => TestResultDetailScreen(testIndex: result['id'] as int),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                // ignore: lines_longer_than_80_chars
                backgroundColor: _getEmojiColor(result['emotionEmoji'] as String),
                child: Text(
                  result['emotionEmoji'] as String,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Lần ${result['id']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cảm xúc : ${result['emotion']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              Text(
                result['date'] as String,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildWelcomeBanner(),
          const SizedBox(height: 20),

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
            return _buildResultCard(context, result);
          }),
          
          // const Divider(height: 40, thickness: 1),

          // const Text(
          //   'Các Bài Test Sàng lọc Khác',
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //     color: primaryColor,
          //   ),
          // ),
          // const SizedBox(height: 15),

          // _buildTestItem(
          //   context, 'Bài kiểm tra Zung', 'Chưa thực hiện', 
          //   Icons.assignment_outlined),
          // _buildTestItem(context, 'Bài kiểm tra Beck', 'Chưa thực hiện', 
          // Icons.psychology_outlined),
  
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}


// =================================================================
// 3. TEST RESULT DETAIL SCREEN (Chi tiết lịch sử)
//    - Đã thiết kế giao diện hoàn toàn MỚI dựa trên yêu cầu tách biệt.
//    - Tự động fetch dữ liệu mock dựa trên testIndex.
// =================================================================

class TestResultDetailScreen extends StatelessWidget {
  final int testIndex;
  
  // ignore: sort_constructors_first
  const TestResultDetailScreen({
    super.key,
    // ignore: always_put_required_named_parameters_first
    required this.testIndex,
  }); 

  // Dữ liệu mock nội bộ (Giả định cho các lần test 1, 2, 3...)
  // ignore: avoid_field_initializers_in_const_classes
  final List<Map<String, dynamic>> mockDetailData = const [
    // Lần 1
    {
      'emotionEmoji': '😮',
      'predictedEmotion': 'Ngạc nhiên',
      'date': '16-08-2025',
      'totalPhotos': 5,
      'emotionBreakdown':  ' 3 Ngạc nhiên,\n 1 Vui vẻ,\n 1 Bình thường',
      'depressionScore': 6,
      'anxietyScore': 4,
      'stressScore': 6,
      // ignore: lines_longer_than_80_chars
      'conclusion': 'Cảm xúc của bạn hiện chưa tốt lắm, nên theo dõi thêm về cảm xúc và giấc ngủ.',
    },
    // Lần 2
    {
      'emotionEmoji': '😡',
      'predictedEmotion': 'Tức giận',
      'date': '20-08-2025',
      'totalPhotos': 8,
      'emotionBreakdown': '5 Tức giận, 2 Buồn, 1 Trung tính',
      'depressionScore': 24,
      'anxietyScore': 16,
      'stressScore': 30,
      // ignore: lines_longer_than_80_chars
      'conclusion': 'Kết quả cho thấy mức độ rối loạn nặng. Bạn nên tham khảo ý kiến chuyên gia.',
    },
    // Lần 3
    {
      'emotionEmoji': '😔',
      'predictedEmotion': 'Buồn',
      'date': '28-08-2025',
      'totalPhotos': 6,
      'emotionBreakdown': '4 Buồn, 2 Bình thường',
      'depressionScore': 15,
      'anxietyScore': 10,
      'stressScore': 20,
      // ignore: lines_longer_than_80_chars
      'conclusion': 'Mức độ rối loạn ở mức vừa phải. Cân nhắc tìm kiếm sự hỗ trợ.',
    },
  ];

  Map<String, dynamic> get _result {
    final data = (testIndex > 0 && testIndex <= mockDetailData.length)
        ? mockDetailData[testIndex - 1]
        : mockDetailData[0]; 

    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả Lần $testIndex'),
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
              onPressed: () {
                // Quay về MainScreen (Tab Home) và xóa Stack
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.home, color: primaryColor, size: 32),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. HEADER (Emoji, Cảm xúc dự đoán, Ngày)
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.yellow.shade100,
                    child: Text(
                      result['emotionEmoji'] as String,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cảm xúc dự đoán: ${result['predictedEmotion']}',
                    style: const TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    result['date'] as String,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // 2. PHÂN TÍCH ẢNH
            _buildSectionTitle('Phân tích hình ảnh:'),
            const SizedBox(height: 15),
            
            _buildDetailRow(
              context, 
              'Tổng số ảnh:', 
              ' ${result['totalPhotos']} ảnh'
            ),
            _buildDetailRow(
              context, 
              'Tổng số cảm xúc:', 
              result['emotionBreakdown'] as String
            ),
            
            const Divider(height: 30, thickness: 1),
            
            _buildSectionTitle('Số điểm qua bài kiểm tra Dass-21:'),
            const SizedBox(height: 15),
            
            Table(
              columnWidths: const {
                // ignore: avoid_redundant_argument_values
                0: FlexColumnWidth(1), 
                1: FixedColumnWidth(10),
                // ignore: avoid_redundant_argument_values
                2: FlexColumnWidth(1),
              },
              children: [
                _buildScoreRow('Trầm cảm:', result['depressionScore'] as int),
                _buildScoreRow('Lo lắng:', result['anxietyScore'] as int),
                _buildScoreRow('Căng thẳng:', result['stressScore'] as int),
              ],
            ),
            
            const Divider(height: 30, thickness: 1),
            
            // 4. KẾT LUẬN CUỐI CÙNG
            _buildSectionTitle('Kết luận:'),
            const SizedBox(height: 10),
            
            Text(
              result['conclusion'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 8, 174, 41),
                height: 1.5,   
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  TableRow _buildScoreRow(String label, int score) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label, style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500, 
            color: Color.fromARGB(255, 0, 0, 0))),
        ),
        const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text('$score', style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150, 
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
