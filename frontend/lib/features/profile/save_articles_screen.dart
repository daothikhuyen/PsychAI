import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/data/model/article.dart';
import 'package:frontend/features/articles/articles_data.dart';
import 'package:frontend/features/articles/articles_detail_screen.dart';

class SavedArticlesScreen extends StatefulWidget {
  const SavedArticlesScreen({super.key});

  @override
  State<SavedArticlesScreen> createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Article> articleObjects;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    articleObjects =
        articles.map((json) {
          final Map<String, dynamic> data = Map<String, dynamic>.from(json);
          data['liked'] ??= false;
          data['saved'] ??= true;
          return Article.fromJson(data);
        }).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: primaryColor, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Đã lưu',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          tabs: const [Tab(text: 'Tất cả'), Tab(text: 'Bài viết')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildAllTabContent(), _buildSavedGrid(articleObjects)],
      ),
    );
  }

  Widget _buildAllTabContent() {
    final recentSaved = articleObjects.take(5).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Text(
              'Lưu mới đây',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: recentSaved.length,
              itemBuilder:
                  (context, index) =>
                      _buildRecentCard(context, recentSaved[index]),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'Tất cả nội dung',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSavedGrid(articleObjects, shrinkWrap: true),
        ],
      ),
    );
  }

  Widget _buildRecentCard(BuildContext context, Article article) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, article),
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl,
                height: 100,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedGrid(List<Article> list, {bool shrinkWrap = false}) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: shrinkWrap,
      physics:
          shrinkWrap
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) => _buildArticleCard(context, list[index]),
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, article),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  article.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      article.source,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticlesDetailScreen(article: article)),
    );
  }
}
