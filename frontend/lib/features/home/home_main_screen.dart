// // lib/features/home/home_main_screen.dart

// import 'package:flutter/material.dart';
// import 'package:frontend/core/constants.dart'; 
// import 'package:frontend/features/home/test_conclusion_screen.dart';

// class HomeMainScreen extends StatelessWidget {
//   const HomeMainScreen({super.key});

//   // ignore: avoid_field_initializers_in_const_classes
//   final List<Map<String, dynamic>> testResults = const [
//     {
//       'id': 1,
//       'date': '16-04-2025',
//       'summary': 'Cảm xúc: Vui vẻ',
//     },
//     {
//       'id': 2,
//       'date': '20-05-2025',
//       'summary': 'Cảm xúc: Bình thường',
//     },
//     {
//       'id': 3,
//       'date': '28-06-2025',
//       'summary': 'Cảm xúc: Buồn',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(24, 70, 24, 24),     
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: infoCardColor,
//               borderRadius: BorderRadius.circular(20),
//              ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: Image.asset(
//                     'assets/images/heart_1.png',
//                     // color: PrimaryColor,
//                     width: 30,
//                     height: 30,
//                   ),
//                 ),
//                 const SizedBox(width: 15),

//                 const Expanded(
//                   child: Text(
//                     // ignore: lines_longer_than_80_chars
//                     'Chúng tôi ở đây, để lắng nghe trái tim bạn',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),

//           const Text(
//             'Các bài kiểm tra',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: primaryColor,
//             ),
//           ),
//           const SizedBox(height: 15),
          
        
//           // Hiển thị các kết quả test đã hoàn thành
//           ...testResults.map((result) {
//             return Card(
//               margin: const EdgeInsets.only(bottom: 10),
//               color: infoCardColor,
//               elevation: 0,
//               child: ListTile(
//                 leading: CircleAvatar(
//                   // ignore: deprecated_member_use
//                   backgroundColor: primaryColor.withOpacity(0.1),
//                   child: Text(
//                     'Lần ${result['id']}',
//                     style: const TextStyle(
//                       color: primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 title: Text(
//                   '${result['summary']}',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Text(
//                   'Ngày kiểm tra: ${result['date']}',
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//                 trailing: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 18,
//                   color: primaryColor,
//                 ),
//                 onTap: () {
//                   // Chuyển đến trang kết quả chi tiết
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) =>
//                               TestResultDetailScreen(testIndex: result['id']),
//                     ),
//                   );
//                 },
//               ),
//             );
//           // ignore: unnecessary_to_list_in_spreads
//           }).toList(),

//           // const Divider(height: 40, thickness: 1),

//           // const Text(
//           //   'Các Bài Test Sàng lọc Khác',
//           //   style: TextStyle(
//           //     fontSize: 24,
//           //     fontWeight: FontWeight.bold,
//           //     color: primaryColor,
//           //   ),
//           // ),
//           // const SizedBox(height: 15),

//           // _buildTestItem(
//           //   context,
//           //   'Bài kiểm tra',
//           //   'Chưa thực hiện',
//           //   Icons.assignment_outlined,
//           // ),
//           // _buildTestItem(
//           //   context,
//           //   'Bài kiểm tra Beck',
//           //   'Chưa thực hiện',
//           //   Icons.psychology_outlined,
//           // ),
  
//           // const SizedBox(height: 50),
//         ],
//       ),
//     );
//   }

//   // Widget _buildTestItem(
//   //   BuildContext context,
//   //   String title,
//   //   String subtitle,
//   //   IconData icon,
//   // ) {
//   //   return Card(
//   //     margin: const EdgeInsets.only(bottom: 10),
//   //     elevation: 1,
//   //     child: ListTile(
//   //       leading: Icon(icon, color: primaryColor, size: 30),
//   //       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//   //       subtitle: Text(subtitle, style: TextStyle(color: Colors.red.shade700)),
//   //       trailing: const Icon(Icons.chevron_right, color: Colors.grey),
//   //       onTap: () {
//   //         //Chuyển đến màn hình chi tiết hoặc bắt đầu bài test mới
//   //         ScaffoldMessenger.of(
//   //           context,
//   //         ).showSnackBar(SnackBar(content: Text('Bắt đầu $title...')));
//   //       },
//   //     ),
//   //   );
  
// }
