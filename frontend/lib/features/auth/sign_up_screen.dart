import 'package:flutter/material.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
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
          const SignUpContent(),
        ],
      ),
    );
  }
}

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key});

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  bool _isPasswordVisible = false;
  static const Color primaryTextColor = Color(0xFF0A4F6A);
  static const Color borderColor = Color(0xFFB0D9E6);
  static const Color buttonColor = Color(0xFFB0D9E6);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Đăng Ký',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 16, 95, 133),
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),

            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Mind Keep',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    foreground:
                        Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = const Color(0xFFF38B61),
                  ),
                ),

                const Text(
                  'Mind Keep',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 203, 226, 247),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: _buildInputDecoration(
                hint: 'Tên',
                prefixIcon: Icons.person_outlined,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),

            TextField(
              decoration: _buildInputDecoration(
                hint: 'Email',
                prefixIcon: Icons.email_outlined,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 28),

            TextField(
              obscureText: !_isPasswordVisible, // Ẩn/hiện mật khẩu
              decoration: _buildInputDecoration(
                hint: 'Mật khẩu',
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bạn đã có tài khoản? ',
                  style: TextStyle(
                    color: Color.fromRGBO(252, 252, 252, 1),
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: ()=> context.push(PageRoutes.signIn),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Color(0xFFEC9D53),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            const Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Color.fromARGB(255, 236, 234, 234),
                  fontSize: 18,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                        'Bằng cách tiếp tục, bạn cho biết'
                        ' rằng bạn đã đọc và đồng ý với ',
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
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      // ignore: lines_longer_than_80_chars
      prefixIcon: Icon(
        prefixIcon,
        color: const Color.fromARGB(255, 255, 255, 255),
        size: 26,
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
        // ignore: lines_longer_than_80_chars
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 176, 217, 230),
          width: 5,
        ),
      ),
    );
  }
}
