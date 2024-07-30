import 'package:dio/dio.dart';
import 'package:physio_app/const/urls.dart';


class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.BASE_URL,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Response> get(String path) async {
    final response = await _dio.get(path);
    return response;
  }

  Future<Response> post(String path, dynamic data, [String? token]) async {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = await _dio.post(path, data: data);
    return response;
  }
}