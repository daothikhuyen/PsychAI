import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  void _showGuidanceDialog(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350, maxHeight: 300),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.notification_add_outlined,
                    color: Color.fromARGB(255, 255, 226, 11),
                    size: 50,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Thông báo hỗ trợ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    'Trong tình huống nguy cấp hoặc cần hỗ trợ, vui lòng tự bấm số $number trên điện thoại của bạn để được kết nối ngay lập tức.',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255,39,195,0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Đã hiểu',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Đóng',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
          'Hỗ trợ khẩn cấp',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: primaryColor, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Bạn đang gặp khó khăn?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              // ignore: lines_longer_than_80_chars
              'Nếu bạn hoặc người thân đang trong tình trạng khủng hoảng hoặc gặp áp lực tâm lý quá lớn, hãy tìm kiếm sự giúp đỡ ngay lập tức.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            _buildActionButton(
              context,
              icon: Icons.phone_in_talk,
              label: 'Số điện thoại hỗ trợ tâm lý',
              color: primaryColor,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Vui lòng tham khảo danh sách số điện thoại phía dưới.',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              context,
              icon: Icons.emergency,
              label: 'Gọi cấp cứu (115)',
              color: Colors.red,
              onTap: () => _showGuidanceDialog(context, '115'),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            _buildHotlineSection(
              context,
              title: 'VIỆT NAM',
              hotlines: [
                {
                  'name': 'Đường dây nóng Ngày Mai (Hỗ trợ trầm cảm)',
                  'number': '0963061630',
                  'desc': 'Mở cửa 08:00 - 20:00 hàng ngày',
                },
                {
                  'name': 'Tổng đài Quốc gia Bảo vệ Trẻ em',
                  'number': '111',
                  'desc': 'Hỗ trợ bạo hành, xâm hại trẻ em 24/7',
                },
                {
                  'name': 'Viện Tâm thần Trung ương 1',
                  'number': '02438515495',
                  'desc': 'Tư vấn và điều trị chuyên sâu',
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 28),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  Widget _buildHotlineSection(
    BuildContext context, {
    required String title,
    required List<Map<String, String>> hotlines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        ...hotlines.map(
          (hotline) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _showGuidanceDialog(context, hotline['number']!),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotline['name']!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Số hỗ trợ: ${hotline['number']}  •  ${hotline['desc']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
