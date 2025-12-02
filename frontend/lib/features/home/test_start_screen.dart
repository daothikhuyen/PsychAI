// import 'package:flutter/material.dart';
// import 'package:frontend/features/test/dass21_test_screen.dart';
// // ignore: directives_ordering
// import 'package:frontend/features/home/upload_image_screen.dart';

// class TestStartScreen extends StatelessWidget {
//   const TestStartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Kiểm tra tâm lý')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Chọn phương thức kiểm tra',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.camera_alt),
//               label: const Text('Tải ảnh để phân tích cảm xúc'),
//               onPressed: () {
//                 // Chuyển sang màn hình Tải ảnh
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const UploadImageScreen(),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.assignment),
//               label: const Text('Thực hiện bài Test Sàng lọc'),
//               onPressed: () {
//                 // Có thể chuyển thẳng đến DASS 21 nếu không cần up ảnh
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const Dass21TestScreen(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
