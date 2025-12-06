// ignore_for_file: public_member_api_docs, sort_constructors_first
class Dass21Result {
  double anxietyScore;
  double depressionScore;
  double stressScore;
  String predictionId;

  Dass21Result({
    required this.anxietyScore,
    required this.depressionScore,
    required this.stressScore,
    required this.predictionId,
  });

  static double _toDoubleSafe(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0;
  }

  factory Dass21Result.fromJson(Map<String, dynamic> json) {
    return Dass21Result(
      anxietyScore: _toDoubleSafe(json['anxiety_score']),
      depressionScore: _toDoubleSafe(json['depression_score']),
      stressScore: _toDoubleSafe(json['stress_score']),
      predictionId: json['prediction_id'] ?? '',
    );
  }

  factory Dass21Result.toJson(Map<String, dynamic> json) {
    return Dass21Result(
      anxietyScore: _toDoubleSafe(json['anxiety_score']),
      depressionScore: _toDoubleSafe(json['depression_score']),
      stressScore: _toDoubleSafe(json['stress_score']),
      predictionId: json['prediction_id'] ?? '',
    );
  }

  static Dass21Result empty() {
    return Dass21Result(
      anxietyScore: 0,
      depressionScore: 0,
      stressScore: 0,
      predictionId: '',
    );
  }
}
