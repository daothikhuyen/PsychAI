import 'package:frontend/core/models/test_result_model.dart';

class Dass21Calculator {
  static TestResult calculateScores(List<Map<String, dynamic>> questions) {
    // ignore: omit_local_variable_types
    int depression = 0; // D
    // ignore: omit_local_variable_types
    int anxiety = 0; // A
    // ignore: omit_local_variable_types
    int stress = 0; // S

    for (final q in questions) {
      final score = q['answer'] as int;
      final scale = q['scale'] as String;

      switch (scale) {
        case 'D':
          depression += score;
          // ignore: unnecessary_breaks
          break;
        case 'A':
          anxiety += score;
          // ignore: unnecessary_breaks
          break;
        case 'S':
          stress += score;
          // ignore: unnecessary_breaks
          break;
      }
    }

    // Nhân đôi điểm số DASS 21
    final doubleD = depression * 2;
    final doubleA = anxiety * 2;
    final doubleS = stress * 2;

    String conclusionText;
    if (doubleD >= 28 || doubleA >= 20 || doubleS >= 34) {
      conclusionText =
          // ignore: lines_longer_than_80_chars
          'Kết quả của bạn cho thấy mức độ rối loạn nghiêm trọng. Vui lòng liên hệ với chuyên gia ngay lập tức.';
    } else if (doubleD >= 21 || doubleA >= 15 || doubleS >= 26) {
      conclusionText =
          // ignore: lines_longer_than_80_chars
          'Bạn đang ở mức độ rối loạn nặng. Bạn nên tham khảo ý kiến chuyên gia càng sớm càng tốt.';
    } else {
      conclusionText =
          // ignore: lines_longer_than_80_chars
          'Mức độ rối loạn của bạn nằm trong mức độ nhẹ hoặc bình thường. Tuy nhiên, hãy tiếp tục theo dõi sức khỏe tinh thần.';
    }

    // ignore: omit_local_variable_types, prefer_single_quotes
    const String predictedEmotion = "Bình thường"; // Giả định

    return TestResult(
      predictedEmotion: predictedEmotion,
      depressionScore: doubleD,
      anxietyScore: doubleA,
      stressScore: doubleS,
      conclusion: conclusionText,
    );
  }
}
