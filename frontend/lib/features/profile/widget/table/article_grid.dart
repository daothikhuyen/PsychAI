// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:frontend/data/model/article.dart';
import 'package:frontend/features/articles/widget/article_card.dart';
import 'package:frontend/features/articles/widget/skeleton.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticleGrid extends StatelessWidget {
  const ArticleGrid({required this.list, super.key, this.shrinkWrap = false});
  final List<Article> list;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      shrinkWrap: shrinkWrap,
      physics:
          shrinkWrap
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: list.isEmpty ? 0.75 : 0.45,
      ),
      itemCount: list.isEmpty ? 6 : list.length,
      itemBuilder: (context, index) {
        return list.isEmpty
            ? Shimmer(
              duration: const Duration(seconds: 4),
              interval: const Duration(seconds: 5),
              colorOpacity: 1,
              child: const SizedBox(height: 50, child: Skeleton()),
            )
            : ArticleCard(article: list[index]);
      },
    );
  }
}
