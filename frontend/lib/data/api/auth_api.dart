import 'package:frontend/data/api/base_api.dart';

class AuthApi {
  // AuthApi({required this.api});
  static final BaseApi _api = BaseApi(() async => null);

  Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await _api.call(
      method: 'POST',
      url: '/auth/signup',
      data: data,
      requireToken: false,
    );
    return response;
  }

  Future<Map<String, dynamic>> signIn(Map<String, dynamic> data) async {
    final response = await _api.call(
      method: 'POST',
      url: '/auth/signin',
      data: data,
      requireToken: false,
    );

    return response;
  }
}
