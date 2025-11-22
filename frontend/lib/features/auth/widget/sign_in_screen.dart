import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0A4F6A),
            size: 38,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
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
          const SignInContent(),
        ],
      ),
    );
  }
}

class SignInContent extends StatefulWidget {
  const SignInContent({super.key});

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent> {
  bool _isPasswordVisible = false;
  static const Color primaryTextColor = Color(0xFF0A4F6A);
  static const Color borderColor = Color(0xFFB0D9E6);
  static const Color buttonColor = Color(0xFFB0D9E6);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 2, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Đăng Nhập',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),

            const Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text:
                        // ignore: lines_longer_than_80_chars
                        'Mỗi ',
                  ),
                  TextSpan(
                    text: 'cảm xúc ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 40, 151, 55),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: 'được nhận diện,\nmột bước'),
                  TextSpan(
                    text: ' nhẹ nhàng ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 40, 151, 55),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: 'chữa lành.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: _buildInputDecoration(
                hint: 'Email',
                prefixIcon: Icons.email_outlined,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            TextField(
              obscureText: !_isPasswordVisible, // Ẩn/hiện mật khẩu
              decoration: _buildInputDecoration(
                hint: 'Mật Khẩu',
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    // Cập nhật trạng thái để build lại UI
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  color: Color(0xFFCEFFFF),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(
                    color: Colors.white, // Màu của viền
                    width: 2, // Độ dày của viền
                  ),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bạn không có tài khoản? ',
                  // ignore: lines_longer_than_80_chars
                  style: TextStyle(
                    color: Color.fromRGBO(252, 252, 252, 1),
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Đăng ký',
                  style: TextStyle(
                    color: Color(0xFFEC9D53),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Row(
              children: [
                Expanded(child: Divider(color: borderColor, thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Hoặc',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: borderColor, thickness: 1)),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton('assets/images/Google.png'),
                const SizedBox(width: 25),
                _buildSocialButton('assets/images/Facebook.png'),
              ],
            ),
            const SizedBox(height: 30),

            const Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Color.fromARGB(255, 236, 234, 234),
                  fontSize: 16,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                        // ignore: lines_longer_than_80_chars
                        'Bằng cách tiếp tục, bạn cho biết rằng bạn đã đọc và đồng ý với ',
                  ),
                  TextSpan(
                    text: 'Điều khoản dịch vụ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' và '),
                  TextSpan(
                    text: 'Chính sách bảo mật',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' của chúng tôi'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child:
            assetPath.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(assetPath, width: 40, height: 20)
                : Image.asset(assetPath, width: 40, height: 30),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      // ignore: lines_longer_than_80_chars
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      // ignore: lines_longer_than_80_chars
      prefixIcon: Icon(
        prefixIcon,
        color: const Color.fromARGB(255, 255, 255, 255),
        size: 22,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      // ignore: deprecated_member_use
      fillColor: Colors.white.withOpacity(0),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color.fromARGB(255, 253, 253, 253)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 176, 217, 230),
          width: 5,
        ),
      ),
    );
  }
}
