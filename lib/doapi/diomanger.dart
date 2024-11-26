import 'package:dio/dio.dart';
import 'package:get/get.dart'as tget;
import 'package:get/get_core/src/get_main.dart';

class DioManager {
  static DioManager? _instance;
  static DioManager getInstance() {
    _instance ??= DioManager._internal();
    return _instance!;
  }

  DioManager._internal();

  Dio dio = Dio();

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    var result = await dio.get(url, queryParameters: params);
    return result;
  }

  Future<Response> post(String url, {Map<String, dynamic>? params}) async {
    var result = await dio.post(url, data: params);
    return result;
  }
}