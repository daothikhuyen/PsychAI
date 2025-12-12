import 'package:flutter/material.dart';
import 'package:frontend/core/themes/app_colors.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({required this.article, super.key});

  final Map<String, dynamic> article;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              article['imageUrl'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),

          Text(
            article['title'] ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            article['description'] ?? '',
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.greyscale400,
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // ignore: avoid_dynamic_calls
          if (article['author'] != null && article['author'].trim().isNotEmpty)
            Text(
              "Tác giả: ${article['author']}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
