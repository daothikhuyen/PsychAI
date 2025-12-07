

import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/news/articles_data.dart';
import 'package:frontend/features/news/news_detail_screen.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen(
    {
      required this.topic, super.key
    });
  final String topic;

  void _returnToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final topicArticles =
        articles.where((a) => a['topic'] == topic).toList();

    final topicName = _topicDisplayName(topic);

    return Scaffold(
      appBar: AppBar(
        title: Text(topicName),
        titleTextStyle: const TextStyle(
          color: primaryColor,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 26,
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => _returnToHome(context),
              icon: const Icon(Icons.home, color: primaryColor, size: 28),
            ),
          ),
        ],
      ),

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topicArticles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final article = topicArticles[index];
                return _buildArticleCard(context, article);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Map<String, dynamic> article) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            NewsDetailScreen(articleId: article['id'] as int),
      ),
    ),
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
            color: inactiveTextColor,
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: inactiveIconColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Tìm kiếm bài viết...',
              style: TextStyle(color: inactiveIconColor),
            ),
          ),
        ],
      ),
    );
  }

  String _topicDisplayName(String key) {
    switch (key) {
      case 'stress_anxiety':
        return 'Căng thẳng, Lo âu';
      case 'life_skills':
        return 'Kỹ năng sống';
      case 'depression':
        return 'Trầm cảm';
      case 'emotional_therapy':
        return 'Trị liệu cảm xúc';
      default:
        return 'Bài viết';
    }
  }
}
