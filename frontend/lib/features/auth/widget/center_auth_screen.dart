import 'dart:ui';
import 'package:flutter/material.dart';

class CenterAuthScreen extends StatelessWidget {
  const CenterAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg5.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: _buildTopContent(screenSize),
                    ),
                  ),
                  _buildBottomContentSheet(screenSize, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopContent(Size screenSize) {
    return Column(
      children: [
        const SizedBox(height: 2),
        Image.asset('assets/images/signup_5.png', width: 300, height: 220),
        const SizedBox(height: 10),
        _buildTitleText(),
        const SizedBox(height: 10),
        _buildSubtitleText(),
        const SizedBox(height: 20),
        _buildPageIndicator(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTitleText() {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          // ignore: deprecated_member_use
          color: const Color.fromRGBO(32, 72, 127, 1).withOpacity(0.8),
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'Hiểu ',
            style: TextStyle(
              color: Color.fromRGBO(32, 72, 127, 1),
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'cảm xúc của ',
            style: TextStyle(
              color: Color.fromRGBO(190, 248, 239, 1),
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: 'bạn'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitleText() {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          // ignore: deprecated_member_use
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'MindKeep',
            style: TextStyle(
              // color: Color.fromRGBO(32, 72, 127, 1),
              color: Color(0xFFEC9D53),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            // ignore: lines_longer_than_80_chars
            text:
                // ignore: lines_longer_than_80_chars
                ' giúp bạn nhận diện và\ntheo dõi trạng thái tinh thần mỗi ngày.',
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContentSheet(Size screenSize, BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 16 + bottomPadding),
          width: double.infinity,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: const Color.fromRGBO(32, 72, 127, 1).withOpacity(0.2),
            // ignore: deprecated_member_use, lines_longer_than_80_chars
            border: Border.all(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStyledButton(
                text: 'Đăng ký ngay',
                onPressed: () {},
                backgroudColor: Colors.transparent,
                textColor: Colors.white,
              ),
              const SizedBox(height: 15),

              _buildStyledButton(
                text: 'Đăng ký với Email',
                onPressed: () {},
                // ignore: deprecated_member_use, lines_longer_than_80_chars
                backgroudColor: const Color.fromRGBO(
                  32,
                  72,
                  127,
                  1,
                  // ignore: deprecated_member_use
                ).withOpacity(0.7),
                textColor: Colors.white,
                imageIconPath: 'assets/images/email.png',
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton('assets/images/Google.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildSocialButton('assets/images/Facebook.png'),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bạn đã có tài khoản?',
                    style: TextStyle(
                      color: Color.fromRGBO(251, 251, 251, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      ' Đăng Nhập',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(32, 72, 127, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroudColor,
    required Color textColor,
    IconData? icon,
    String? imageIconPath,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        // ignore: deprecated_member_use
        side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.5),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
          ] else if (imageIconPath != null) ...[
            Image.asset(imageIconPath, width: 24, height: 24),
            const SizedBox(width: 10),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String imagePath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image.asset(imagePath, width: 30, height: 30),
      ),
    );
  }
}
