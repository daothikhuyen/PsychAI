import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future<void> showSignOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/question.svg'),
              const SizedBox(height: 16),
              const Text('Are You Sure'),
              const Text('Do You Want To Logout'),
              const SizedBox(height: 16),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ],
          ),
        ),
      );
    },
  );
}
