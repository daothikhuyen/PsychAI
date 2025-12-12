import 'package:flutter/material.dart';
import 'package:frontend/features/news/topic_screen.dart';
import 'package:frontend/features/news/widget/topic/topic_card.dart';

class TopicSection extends StatelessWidget {
  const TopicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TopicCard(
                title: 'Căng thẳng, Lo âu',
                postCount: '7 bài viết',
                imageUrl: 'assets/images/card1.jpg',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => const TopicScreen(topic: 'stress_anxiety'),
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TopicCard(
                title: 'Kỹ năng sống',
                postCount: '3 bài viết',
                imageUrl: 'assets/images/card2.jpg',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TopicScreen(topic: 'life_skills'),
                      ),
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TopicCard(
                title: 'Trầm cảm',
                postCount: '5 bài viết',
                imageUrl: 'assets/images/card3.jpg',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TopicScreen(topic: 'depression'),
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TopicCard(
                title: 'Trị liệu cảm xúc',
                postCount: '7 bài viết',
                imageUrl: 'assets/images/card4.jpg',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                const TopicScreen(topic: 'emotional_therapy'),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
