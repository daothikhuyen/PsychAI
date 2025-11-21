import 'dart:convert';
import 'package:frontend/core/exception/api_exception.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  BaseApi(this.getToken);

  final String baseUrl = 'http://10.0.2.2:8000/api';
  final Future<String?> Function()? getToken;

  Future<dynamic> call({
    required String method,
    required String url,
    Map<String, dynamic>? data,
    bool requireToken = true,
  }) async {
    final fullUrl = Uri.parse('$baseUrl$url');

    String? token;
    if (requireToken) {
      token = await getToken?.call();
    }

    // create header
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    http.Response response;

    switch (method.toUpperCase()) {
      case 'POST':
        {
          response = await http.post(
            fullUrl,
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        }

      case 'GET':
        {
          response = await http.get(fullUrl, headers: headers);
          break;
        }

      case 'PUT':
        {
          response = await http.put(
            fullUrl,
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        }

      case 'DELETE':
        {
          response = await http.delete(fullUrl, headers: headers);
          break;
        }

      default:
        throw Exception('HTTP method không hợp lệ: $method');
    }

    final body = jsonDecode(response.body) as Map<String,dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      throw ApiException(message: body['message'], code: response.statusCode);
    }
  }
}
