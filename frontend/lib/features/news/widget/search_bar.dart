import 'package:flutter/material.dart';
import 'package:frontend/core/themes/app_colors.dart';

class ArticlesSearchBar extends StatelessWidget {
  const ArticlesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.greyscale0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyscale400),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.greyscale500),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Tìm kiếm bài viết...',
              style: TextStyle(color: AppColors.greyscale500),
            ),
          ),
        ],
      ),
    );
  }
}
