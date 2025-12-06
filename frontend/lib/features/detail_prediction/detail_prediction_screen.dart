import 'package:flutter/material.dart';
import 'package:frontend/core/themes/app_colors.dart';
import 'package:frontend/core/uitls/format.dart';
import 'package:frontend/data/model/dass21_result.dart';
import 'package:frontend/data/model/predictions.dart';
import 'package:frontend/features/detail_prediction/widget/detail_row.dart';
import 'package:frontend/features/detail_prediction/widget/score_row.dart';
import 'package:frontend/features/detail_prediction/widget/section_title.dart';
import 'package:frontend/features/home/helper/emoji_helper.dart';
import 'package:frontend/core/widgets/devider.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPredictionScreen extends StatelessWidget {
  const DetailPredictionScreen({
    required this.prediction,
    required this.resultTest,
    required this.count,
    super.key,
  });

  final Predictions prediction;
  final Dass21Result resultTest;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kết quả Lần $count'),
        titleTextStyle: const TextStyle(
          color: AppColors.backgroundDart,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () => context.go(PageRoutes.homePage),
              icon: const Icon(
                Icons.home,
                color: AppColors.greyscale700,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: getEmojiColor(prediction.finalEmotion),
                    child: Text(
                      getEmoji(prediction.finalEmotion),
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cảm xúc dự đoán: ${prediction.finalEmotion}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatDateTypeTwo(prediction.createdAt),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.greyscale400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const SectionTitle(title: 'Phân tích hình ảnh:'),
            const SizedBox(height: 15),

            DetailRow(
              label: 'Tổng số ảnh:',
              value: '${prediction.emotions.length} Hình ảnh',
            ),
            DetailRow(
              label: 'Tổng số cảm xúc:',
              value: countEmotions(prediction.emotions),
            ),

            const PsychDevider(),

            const SectionTitle(title: 'Số điểm qua bài kiểm tra Dass-21:'),
            const SizedBox(height: 15),

            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.05),
                1: FixedColumnWidth(10),
                2: FlexColumnWidth(1.05),
              },
              children: [
                buildScoreRow('Trầm cảm:', resultTest.depressionScore),
                buildScoreRow('Lo lắng:', resultTest.anxietyScore),
                buildScoreRow('Căng thẳng:', resultTest.stressScore),
              ],
            ),

            const PsychDevider(),

            const SectionTitle(title: 'Kết luận:'),
            const SizedBox(height: 10),

            const Text(
              'Cảm xúc của bạn hiện chưa tốt lắm, nên theo '
              'dõi thêm về cảm xúc và giấc ngủ.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 8, 174, 41),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
