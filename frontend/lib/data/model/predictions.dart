class Predictions {
  Predictions({
    required this.id,
    required this.email,
    required this.userId,
    required this.emotions,
    required this.finalEmotion,
    required this.createdAt,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) => Predictions(
    id: json['id'],
    email: json['email'],
    userId: json['user_id'],
    emotions: json['emotions'],
    finalEmotion: json['final_emotion'],
    createdAt: DateTime.parse(json['created_at']),
  );

  factory Predictions.toJson(Map<String, dynamic> json) => Predictions(
    id: json['id'],
    email: json['email'],
    userId: json['user_id'],
    emotions: json['emotions'],
    finalEmotion: json['final_emotion'],
    createdAt: DateTime.parse(json['created_at']),
  );

  String id;
  String email;
  String userId;
  List<dynamic> emotions;
  String finalEmotion;
  DateTime createdAt;
}
