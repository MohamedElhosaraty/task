import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/shared_pref_helper.dart';
import '../helpers/shared_prefs_keys.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Future<void> init() async {
    Duration timeOut = const Duration(minutes: 1);

    dio = Dio();
    dio!.options
      ..connectTimeout = timeOut
      ..receiveTimeout = timeOut;

    dio!.options.headers = {
      'Accept': 'application/json',
    };

    _addDioInterceptor();
  }

  static Dio getDio() {
    if (dio == null) {
      throw Exception("Dio is not initialized. Call DioFactory.init() first.");
    }
    return dio!;
  }

  static void _addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getSecuredString(SharedPrefsKeys.tokenKey);

          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          debugPrint("Request sent with token: $token");
          return handler.next(options);
        },
        onError: (error, handler) {
          debugPrint("Dio error: ${error.message}");
          return handler.next(error);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}