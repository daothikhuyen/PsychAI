import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/core/models/test_result_model.dart';
import 'package:frontend/features/home/home_welcome_screen.dart';
import 'package:frontend/features/home/test_conclusion_screen.dart';
import 'package:frontend/features/home/upload_image_screen.dart';
// import 'package:frontend/features/home/test_conclusion_screen.dart';
// import 'package:frontend/features/home/test_start_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // Khởi tạo trạng thái giả định:
  // ignore: prefer_final_fields, unused_field
  bool _hasTestResults = false;

  // Hàm này sẽ quyết định hiển thị màn hình Home nào
  // Widget get _homeScreen {
  //   // if (_hasTestResults) {
  //   //   return const UploadImageScreen();
  //   // } else {
  //   //   return const HomeWelcomeScreen();
  //   // }
  //   return const HomeWelcomeScreen();
  // }
  Widget get _homeScreen {
  if (_hasTestResults) {
    // TẠO DỮ LIỆU MOCK KẾT QUẢ ĐẦU TIÊN
    final mockResult = TestResult(
      predictedEmotion: 'Bình thường',
      depressionScore: 0,
      anxietyScore: 0,
      stressScore: 0,
      conclusion: 'Chào mừng! Bắt đầu bài test đầu tiên của bạn.',
    );

    // Truyền dữ liệu MOCK
    return TestConclusionScreen(result: mockResult); // <--- SỬA: TRUYỀN DỮ LIỆU
  } else {
    return const HomeWelcomeScreen();
  }
}

  // Danh sách pages giờ đây sẽ gọi đến getter _homeScreen
  late final List<Widget> _pages = [
    _homeScreen,
    // ignore: prefer_single_quotes
    const Center(child: Text("Test FAB")), // <-- Màn hình Home động
    // ignore: prefer_single_quotes
    const Center(child: Text("News Screen")),
    // ignore: prefer_single_quotes
    const Center(child: Text("Chatbot Screen")),
    // ignore: prefer_single_quotes
    const Center(child: Text("Profile Screen")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startTestFlow() {
    // Chuyển sang màn hình bắt đầu luồng test (dùng Navigator.push)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadImageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
          child: CircleAvatar(
            // ignore: unnecessary_const
            backgroundImage: const AssetImage('assets/images/user.jpg'),
          ),
        ),
        titleSpacing: 22,
        title: const Text(
          'My Khuyenn',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black54, size: 28),
          ),
        ],
      ),

      body: IndexedStack(index: _selectedIndex, children: _pages),

      floatingActionButton: FloatingActionButton(
        onPressed: _startTestFlow,
        backgroundColor: fabColor,
        elevation: 2,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: buttonColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomItem(Icons.home, 'Trang chủ', 0),
            _bottomItem(Icons.article_outlined, 'Tin tức', 1),
            const SizedBox(width: 44),
            _bottomItem(Icons.chat, 'Chatbot', 2),
            _bottomItem(Icons.person_outline, 'Cá nhân', 3),
          ],
        ),
      ),
    );
  }

  Widget _bottomItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : inactiveIconColor,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isSelected ? primaryColor : inactiveIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// lib/features/home/home_welcome_screen.dart

// import 'package:flutter/material.dart';
// import 'package:frontend/core/constants.dart';

// // Import TestStartScreen không cần thiết vì callback sẽ xử lý điều hướng

// class HomeWelcomeScreen extends StatelessWidget {
//   // Thêm callback để MainScreen xử lý luồng điều hướng
//   final VoidCallback onStartTestPressed; 
  
//   // ignore: sort_constructors_first
//   const HomeWelcomeScreen({
//     super.key,
//     // ignore: always_put_required_named_parameters_first
//     required this.onStartTestPressed, // <--- THÊM REQUIRED CALLBACK
//   });

//   // Loại bỏ hàm _startFirstTest không cần thiết

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const ClampingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 20,
//           right: 20,
//           top: 50,
//           bottom: 180,
//         ),
//         child: Column(
//           children: [
//             // ... (Giữ nguyên phần Text.rich và Container info card)
//             const Align(
//               // alignment: Alignment.center,
//               child: Text.rich(
//                 textAlign: TextAlign.center,
//                 TextSpan(
//                   text: 'Chào mừng bạn đến với\n',
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontSize: 26,
//                     fontWeight: FontWeight.w900,
//                     height: 1.4,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: 'Mind',
//                       style: TextStyle(
//                         color: logoColor,
//                         fontSize: 32,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Keep',
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 2, 124, 39),
//                         fontSize: 32,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
          
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: infoCardColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     child: Image.asset(
//                       'assets/images/Together1.png',
//                       // color: PrimaryColor,
//                       width: 50,
//                       height: 50,
//                     ),
//                   ),
//                   const SizedBox(width: 15),

//                   const Expanded(
//                     child: Text(
//                       'Hãy cùng chúng tôi lắng nghe và thấu hiểu sức khỏe tinh thần của bạn',
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 0, 0, 0),
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),

//             // Nút BẮT ĐẦU
//             GestureDetector(
//               onTap: onStartTestPressed, // <--- Gọi callback từ MainScreen
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: buttonColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               child: const Column(
//                 children: [
//                   Text(
//                     'BẮT ĐẦU',
//                     style: TextStyle(
//                       color: primaryColor,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'BÀI KIỂM TRA ĐẦU TIÊN',
//                     style: TextStyle(
//                       color: primaryColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//             const SizedBox(height: 30),
//             const Text(
//               'Bạn chỉ mất 5 phút để nhận\nđánh giá đầu tiên',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: primaryColor,
//                 fontSize: 18,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.w600,
//                 height: 1.4,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
