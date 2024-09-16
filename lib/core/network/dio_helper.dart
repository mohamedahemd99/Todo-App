import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../helpers/preferences/pref_manager.dart';
import 'api_path.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: AppApiPaths.url,
      connectTimeout: const Duration(milliseconds: 100 * 1000),
      receiveTimeout: const Duration(milliseconds: 80 * 1000),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
    dio!.interceptors.add(InterceptorsWrapper(
      onResponse: (e, handler) {
        logger.d(
          'RESPONSE Status[${e.requestOptions}] => PATH: ${e.requestOptions.extra}',
        );
        logger.d(
          'RESPONSE Object[${e.data}] => PATH: ${e.requestOptions.path}',
        );
        if (e.statusCode == 401) {}
        return handler.next(e);
      },
      onError: (DioError error, handler) async {
        print(
            "Error[${error.response?.statusCode}] => DATA: ${error.response?.data}");
        return handler.next(error);
      },
    ));
    // Add logger in debug mode
    if (kDebugMode) {
      dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  static Future<dynamic> uploadFiles(String url,
      {required File file, bool isAuth = true}) async {
    if (isAuth) {
      await authorize();
    }
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": [
        await MultipartFile.fromFile(
          file.path, filename: fileName,
          contentType: MediaType('image', 'jpeg'), // Or 'png' if it's a PNG
        ),
      ]
    });
    try {
      final Response response = await dio!.post(url,
          data: formData,
          options: Options(
              validateStatus: (int? status) {
                return true;
              },
              contentType:
                  "multipart/form-data; boundary=<calculated when request is sent>"));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> authorize() async {
    dio!.options.headers['Authorization'] = "Bearer ${PrefManager.getToken()}";
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    data,
  }) async {
    String? token = PrefManager.getToken();
    return await dio!.get(url,
        queryParameters: query,
        options: Options(
          validateStatus: (int? status) {
            return true;
          },
          headers: {"Authorization": "Bearer $token"},
        ));
  }

  static Future<Response> postData(
      {required String url, data, bool isAuth = true}) async {
    if (isAuth) {
      await authorize();
    }
    String? token = PrefManager.getToken();
    return await dio!.post(url,
        data: data,
        options: Options(
          validateStatus: (int? status) {
            return true;
          },
          headers: {"Authorization": "Bearer $token"},
        ));
  }

  static Future<Response> putData(
      {required String url, data, bool isAuth = true}) async {
    if (isAuth) {
      await authorize();
    }
    String? token = PrefManager.getToken();
    return await dio!.put(url,
        data: data,
        options: Options(
          validateStatus: (int? status) {
            return true;
          },
          headers: {"Authorization": "Bearer $token"},
        ));
  }

  // New deleteData method
  static Future<Response> deleteData({
    required String url,
    bool isAuth = true,
    Map<String, dynamic>? data,
  }) async {
    if (isAuth) {
      await authorize();
    }
    String? token = PrefManager.getToken();
    return await dio!.delete(url,
        data: data,
        options: Options(
          validateStatus: (int? status) {
            return true;
          },
          headers: {"Authorization": "Bearer $token"},
        ));
  }
}

Logger logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
    methodCount: 1,
    errorMethodCount: 2,
    colors: false,
  ),
);
