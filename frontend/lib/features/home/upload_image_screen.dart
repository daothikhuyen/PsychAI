import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/home/initial_result_screen.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  // Mock list để mô phỏng việc chọn ảnh
  // ignore: prefer_final_fields
  List<String> _uploadedImages = [];
  final int minImagesRequired = 5;

  // Hàm giả lập việc chọn ảnh
  void _pickImage() {
    setState(() {
      if (_uploadedImages.length < 10) {
        // Giả lập tối đa 10 ảnh
        _uploadedImages.add('Ảnh ${_uploadedImages.length + 1}');
      }
    });
  }

  // Hàm xử lý khi nhấn nút Xong (Xem kết quả)
  void _onDonePressed() {
    if (_uploadedImages.length >= minImagesRequired) {
      // Gọi hộp thoại kết quả thay vì chuyển sang màn hình Scaffold
      InitialResultScreen.show(context);
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: omit_local_variable_types, prefer_final_locals, unused_local_variable
    bool isButtonActive = _uploadedImages.length >= minImagesRequired;

    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
        title: const Text('Kiểm tra Tâm lý'),
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
          color: primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home, color: primaryColor, size: 28),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildImageUploadArea(context),

            const SizedBox(height: 20),

            SizedBox(
              height: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _uploadedImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0F7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _uploadedImages[index],
                      style: const TextStyle(color: Color(0xFF3B5B84)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
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
            'Xong',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadArea(BuildContext context) {
    // ignore: omit_local_variable_types, prefer_final_locals
    bool isButtonActive = _uploadedImages.length >= minImagesRequired;

    return GestureDetector(
      onTap: _pickImage, 
      child: DottedBorderContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: Color(0xFF3B5B84),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tải hình ảnh',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 8),
              // Yêu cầu và số lượng ảnh đã chọn
              Text(
                'Vui lòng tải lên ít nhất $minImagesRequired ảnh (${_uploadedImages.length}/$minImagesRequired)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color:
                      isButtonActive
                          ? Colors.green.shade900
                          : primaryColor,
                  fontWeight:
                      isButtonActive ? FontWeight.w700 : FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final Widget child;

  // ignore: sort_constructors_first, always_put_required_named_parameters_first
  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(),
      child: Padding(padding: const EdgeInsets.all(8), child: child),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          // ignore: deprecated_member_use
          ..color = const Color(0xFF3B5B84).withOpacity(0.5)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;
          
    const double dashWidth = 8;
    const double dashSpace = 4;
    // ignore: unused_local_variable
    const double radius = 30;

    // ignore: omit_local_variable_types
    final RRect rRect = RRect.fromRectAndRadius(
      Offset.zero & size, 
      const Radius.circular(radius), 
    );
    // ignore: omit_local_variable_types
    final Path path = Path()..addRRect(rRect);

    // ignore: omit_local_variable_types
    final PathMetrics pathMetrics = path.computeMetrics();
    // ignore: omit_local_variable_types
    for (final PathMetric pathMetric in pathMetrics) {
      double currentLength = 0;
      while (currentLength < pathMetric.length) {
        // ignore: omit_local_variable_types
        final double end = currentLength + dashWidth;
        // ignore: omit_local_variable_types
        final Path extractPath = pathMetric.extractPath(
          currentLength,
          end.clamp(0.0, pathMetric.length), 
        );
        canvas.drawPath(extractPath, paint);
        currentLength = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
