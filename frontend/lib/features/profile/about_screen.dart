import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  void _returnToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Giới thiệu ứng dụng',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () => Navigator.pop(context),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContentSection(
              icon: Icons.flag_outlined,
              title: 'Mục tiêu phát triển',
              content:
                  // ignore: lines_longer_than_80_chars
                  'Ứng dụng được phát triển nhằm cung cấp một giải pháp công nghệ tiên tiến trong việc theo dõi sức khỏe tinh thần. Bằng cách sử dụng trí tuệ nhân tạo để nhận diện cảm xúc qua khuôn mặt và giọng nói, hệ thống giúp người dùng hiểu rõ hơn về trạng thái tâm lý hàng ngày của mình.',
            ),
            _buildContentSection(
              icon: Icons.settings_suggest_outlined,
              title: 'Cơ chế hoạt động',
              content:
                  // ignore: lines_longer_than_80_chars
                  'Thông qua các thuật toán học máy, ứng dụng phân tích các biểu hiện cảm xúc nhỏ nhất, từ đó đưa ra các cảnh báo sớm về các dấu hiệu rối loạn tâm lý như trầm cảm, lo âu hay căng thẳng kéo dài.',
            ),
            _buildContentSection(
              icon: Icons.volunteer_activism_outlined,
              title: 'Ý nghĩa và tầm nhìn',
              content:
                  // ignore: lines_longer_than_80_chars
                  'Chúng tôi mong muốn tạo ra một người bạn đồng hành số, giúp thu hẹp khoảng cách giữa người dùng và các chuyên gia tâm lý, tạo điều kiện để mọi người tiếp cận với sự hỗ trợ tinh thần một cách kịp thời và hiệu quả nhất.',
            ),
            const SizedBox(height: 40),
            const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8),
                  Text(
                    'Vì một cộng đồng khỏe mạnh về tâm trí ',
                    style: TextStyle(
                      color: greenTextColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.favorite, color: Color.fromARGB(255, 245, 38, 38)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color.fromARGB(255, 54, 54, 54),
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
