import 'package:flutter/cupertino.dart';
import 'package:frontend/core/themes/app_colors.dart';

class CardTextItem extends StatelessWidget {
  const CardTextItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.greyscale100,
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
}
