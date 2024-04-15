import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: 'https://655dab5d9f1e1093c599abbf.mockapi.io/',
  connectTimeout: 5000,
  receiveTimeout: 3000,
));

class ApiClient {
  Future<Response> get(String path) async {
    try {
      final response = await dio.get(Uri.encodeFull(path));
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await dio.post(Uri.encodeFull(path), data: data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await dio.put(Uri.encodeFull(path), data: data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(Uri.encodeFull(path));
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
