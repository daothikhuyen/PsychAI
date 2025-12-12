import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/news/articles_data.dart';
import 'package:frontend/features/news/widget/article_card.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({required this.topic, super.key});
  final String topic;

  void _returnToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final topicArticles = articles.where((a) => a['topic'] == topic).toList();

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
            const SearchBar(),
            const SizedBox(height: 16),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topicArticles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final article = topicArticles[index];
                return ArticleCard(article: article);
              },
            ),
          ],
        ),
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
