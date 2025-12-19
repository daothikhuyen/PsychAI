import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  GeminiService(this.apiKey);
  final String apiKey;

  Future<String> generateReply(String userInput) async {
    final url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': userInput}
          ]
        }
      ]
    });

    final response = await http.post(
      Uri.parse(url), headers: headers, body: body
      );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // ignore: avoid_dynamic_calls
      final reply = data['candidates']?[0]['content']?['parts']?[0]['text'];
      return reply ?? 'Không có phản hồi từ Gemini.';
    } else {
      return 'Lỗi API: ${response.body}';
    }
  }
}
