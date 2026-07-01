import 'package:dio/dio.dart';

import '../helpers/shared_pref_helper.dart';
import '../networking/api_constants.dart';

class ApiManager {
  final Dio dio;

  ApiManager( {required this.dio});


  Future<Response> post({
    required String endPoint,
    required dynamic data,
  }) async {
    final response = await dio.post(
      ApiConstants.baseUrl + endPoint,
      data: data,
    );

    return response;
  }

  Future<Response> get({required String endPoint}) async {
    final isEnglish = SharedPrefHelper.getBool('isEnglish');
    final languageCode = isEnglish ? 'en' : 'ar';
    final response = await dio.get(
      ApiConstants.baseUrl + endPoint,
      options: Options(
        headers: {
          "Accept-Language": languageCode,
        },
      ),
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
