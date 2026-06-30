import 'package:dio/dio.dart';

import '../networking/api_constants.dart';

class ApiManager {
  final Dio dio;

  ApiManager( {required this.dio});


  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post(
      ApiConstants.baseUrl + endPoint,
      data: data,
    );

    return response;
  }

  Future<Response> get({required String endPoint}) async {
    final response = await dio.get(
      ApiConstants.baseUrl + endPoint,
    );

    return response;
  }

  Future<Response> delete({required String endPoint,required Map<String, dynamic> data,}) async {
    final response = await dio.delete(
      ApiConstants.baseUrl + endPoint,
      data: data,

    );

    return response;
  }

  Future<Response> patch({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.patch(
      ApiConstants.baseUrl + endPoint,
      data: data,
    );

    return response;
  }
}
