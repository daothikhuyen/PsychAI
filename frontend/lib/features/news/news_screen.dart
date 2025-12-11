import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/news/articles_data.dart';
import 'package:frontend/features/news/news_detail_screen.dart';
import 'package:frontend/features/news/topic_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  void _returnToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final article1 = articles.firstWhere((a) => a['id'] == 1);
    final article2 = articles.firstWhere((a) => a['id'] == 2);
    final article3 = articles.firstWhere((a) => a['id'] == 3);
    final article4 = articles.firstWhere((a) => a['id'] == 4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tin Tức Sức Khỏe'),
        titleTextStyle: const TextStyle(
          color: primaryColor,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 15),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nổi bật',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Đề xuất',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildHighlightCard(
                    title: article2['title'],
                    imageUrl: article2['imageUrl'],
                    onTap: () => _openDetail(context, 2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildSmallHighlightCard(
                        title: article1['title'],
                        // ignore: avoid_dynamic_calls
                        tag: article1['tags'][0],
                        imageUrl: article1['imageUrl'],
                        onTap: () => _openDetail(context, 1),
                      ),
                      const SizedBox(height: 16),
                      _buildSmallHighlightCard(
                        title: article3['title'],
                        // ignore: avoid_dynamic_calls
                        tag: article3['tags'][0],
                        imageUrl: article3['imageUrl'],
                        onTap: () => _openDetail(context, 3),
                      ),
                      const SizedBox(height: 16),
                      _buildSmallHighlightCard(
                        title: article4['title'],
                        // ignore: avoid_dynamic_calls
                        tag: article4['tags'][0],
                        imageUrl: article4['imageUrl'],
                        onTap: () => _openDetail(context, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Theo chủ đề',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildTopicSection(context),
          ],
        ),
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
              'Tìm kiếm...',
              style: TextStyle(
                color: inactiveIconColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallHighlightCard({
    required String title,
    required String imageUrl,
    required String tag,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                width: 50,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tag,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTopicCard(
                title: 'Căng thẳng, Lo âu',
                postCount: '7 bài viết',
                imageUrl: 'assets/images/card1.jpg',
                onTap: () => Navigator.push(
                  context,
                  // ignore: lines_longer_than_80_chars
                  MaterialPageRoute(builder: (_) => const TopicScreen(topic: 'stress_anxiety')),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTopicCard(
                title: 'Kỹ năng sống',
                postCount: '3 bài viết',
                imageUrl: 'assets/images/card2.jpg',
                onTap: () => Navigator.push(
                  context,
                  // ignore: lines_longer_than_80_chars
                  MaterialPageRoute(builder: (_) => const TopicScreen(topic: 'life_skills')),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTopicCard(
                title: 'Trầm cảm',
                postCount: '5 bài viết',
                imageUrl: 'assets/images/card3.jpg',
                onTap: () => Navigator.push(
                  context,
                  // ignore: lines_longer_than_80_chars
                  MaterialPageRoute(builder: (_) => const TopicScreen(topic: 'depression')),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTopicCard(
                title: 'Trị liệu cảm xúc',
                postCount: '7 bài viết',
                imageUrl: 'assets/images/card4.jpg',
                onTap: () => Navigator.push(
                  context,
                  // ignore: lines_longer_than_80_chars
                  MaterialPageRoute(builder: (_) => const TopicScreen(topic: 'emotional_therapy')),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopicCard({
    required String title,
    required String postCount,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              postCount,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NewsDetailScreen(articleId: id)),
    );
  }
}
