import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/features/news/articles_data.dart';
import 'package:frontend/features/news/news_screen.dart';
import 'package:frontend/features/news/widget/card_articles_sugesstion.dart';
import 'package:frontend/features/news/widget/tag_item.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({required this.articleId, super.key});
  final int articleId;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final article = articles.firstWhere((a) => a['id'] == widget.articleId);

    final formattedDate = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.parse(article['publishedAt']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết bài báo'),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NewsScreen()),
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              '${article['author']}  •  ${article['source']}  •  $formattedDate',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                article['imageUrl'],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => isLiked = !isLiked);
                  },
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.black,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Thích',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isLiked ? Colors.red : inactiveIconColor,
                  ),
                ),

                const SizedBox(width: 20),

                GestureDetector(
                  onTap: () {
                    setState(() => isBookmarked = !isBookmarked);
                  },
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? Colors.amber : Colors.black,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Đánh dấu',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isBookmarked ? Colors.amber : inactiveIconColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              children: List.generate(
                article['tags'].length,
                (i) => TagItem(tag: article['tags'][i]),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              article['description'],
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 10),

            Text(
              article['content'],
              style: const TextStyle(fontSize: 17, height: 1.5),
            ),
            const SizedBox(height: 15),

            const Text(
              'Đề xuất',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final a in articles.where(
                    (e) => e['id'] != widget.articleId,
                  ))
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: CardArticlesSugesstion(
                        id: a['id'],
                        title: a['title'],
                        imageUrl: a['imageUrl'],
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
}
