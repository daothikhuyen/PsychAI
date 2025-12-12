import 'package:flutter/material.dart';
import 'package:frontend/core/themes/app_colors.dart';
import 'package:frontend/features/news/articles_data.dart';
import 'package:frontend/features/news/news_detail_screen.dart';
import 'package:frontend/features/news/widget/highlight/highlight_card.dart';
import 'package:frontend/features/news/widget/highlight/small_highlight_card.dart';
import 'package:frontend/features/news/widget/search_bar.dart';
import 'package:frontend/features/news/widget/topic/topic_section.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

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
          color: AppColors.greyscale800,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 26,
          color: AppColors.greyscale800,
          onPressed: () => context.pop(PageRoutes.homePage),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => context.pop(PageRoutes.homePage),
              icon: const Icon(
                Icons.home,
                color: AppColors.greyscale800,
                size: 28,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ArticlesSearchBar(),
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
                  child: HighlightCard(
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
                      SmallHighlightCard(
                        title: article1['title'],
                        // ignore: avoid_dynamic_calls
                        tag: article1['tags'][0],
                        imageUrl: article1['imageUrl'],
                        onTap: () => _openDetail(context, 1),
                      ),
                      const SizedBox(height: 16),
                      SmallHighlightCard(
                        title: article3['title'],
                        // ignore: avoid_dynamic_calls
                        tag: article3['tags'][0],
                        imageUrl: article3['imageUrl'],
                        onTap: () => _openDetail(context, 3),
                      ),
                      const SizedBox(height: 16),
                      SmallHighlightCard(
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

            const TopicSection(),
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
