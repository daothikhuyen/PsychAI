import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/core/themes/app_colors.dart';
import 'package:frontend/core/widgets/textfield.dart';
import 'package:frontend/features/articles/articles_data.dart';
import 'package:frontend/features/articles/controller/article_controller.dart';
import 'package:frontend/features/articles/widget/article_card.dart';
import 'package:frontend/features/articles/widget/highlight/highlight_card.dart';
import 'package:frontend/features/articles/widget/highlight/small_highlight_card.dart';
import 'package:frontend/features/articles/widget/skeleton.dart';
import 'package:frontend/features/topic_article/controller/topic_article_controller.dart';
import 'package:frontend/features/topic_article/widget/topic_section.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final search = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleController>().getTopArticle(context);
      context.read<TopicArticleController>().getTopics(context);
    });

    search.addListener(() {
      final text = search.text.trim();
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (text.isEmpty) {
          context.read<ArticleController>().clearSearch();
        }
        context.read<ArticleController>().search(context, search.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final articleController = Provider.of<ArticleController>(context);
    final article1 = articles.firstWhere((a) => a['id'] == 1);
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
            PredictTextField(
              hint: 'Tìm kiếm...',
              prefixIcon: Icons.search,
              border: 8,
              color: AppColors.greyscale500,
              controller: search,
              size: 8,
            ),
            const SizedBox(height: 15),

            if (articleController.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              articleController.listArticleSearched.isEmpty
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Nổi bật',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Đề xuất',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (articleController.articlePropose.isNotEmpty)
                            ...articleController.articlePropose.map((e) {
                              return Expanded(
                                flex: 2,
                                child: HighlightCard(
                                  title: e.title,
                                  imageUrl: e.imageUrl,
                                  onTap:
                                      () => context.push(
                                        PageRoutes.detailArticle,
                                        extra: e,
                                      ),
                                ),
                              );
                            })
                          else
                            Shimmer(
                              duration: const Duration(seconds: 4),
                              interval: const Duration(seconds: 5),
                              colorOpacity: 1,
                              child: const Skeleton(),
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
                                  onTap: () {},
                                ),
                                const SizedBox(height: 16),
                                SmallHighlightCard(
                                  title: article3['title'],
                                  // ignore: avoid_dynamic_calls
                                  tag: article3['tags'][0],
                                  imageUrl: article3['imageUrl'],
                                  onTap: () {},
                                ),
                                const SizedBox(height: 16),
                                SmallHighlightCard(
                                  title: article4['title'],
                                  // ignore: avoid_dynamic_calls
                                  tag: article4['tags'][0],
                                  imageUrl: article4['imageUrl'],
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Theo chủ đề',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 10),

                      const TopicSection(),
                    ],
                  )
                  : Column(
                    children: [
                      ...articleController.articlePropose.map((e) {
                        return ArticleCard(article: e);
                      }),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
