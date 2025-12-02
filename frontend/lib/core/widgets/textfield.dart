import 'package:flutter/material.dart';
import 'package:frontend/core/themes/app_colors.dart';

class PredictTextField extends StatelessWidget {
  const PredictTextField({
    required this.hint,
    required this.prefixIcon,
    this.focusNode,
    super.key,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.controller,
  });
  final String hint;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      prefixIcon: Icon(prefixIcon, color: Colors.white, size: 22),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: Colors.white.withValues(alpha: 0),

      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 176, 217, 230),
          width: 5,
        ),
      ),

      errorStyle: const TextStyle(
        color: AppColors.error200,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: _buildDecoration(),
    );
  }
}
