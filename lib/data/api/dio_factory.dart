import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constants.dart';

const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ACCESS_CONTROL_O = "Access-Control-Allow-Origin";
const String ACCESS_CONTROL_H = "Access-Control-Allow-Headers";
const String APPLICATION_JSON = "application/json";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      // CONTENT_TYPE: APPLICATION_JSON,
      // ACCEPT: APPLICATION_JSON,
      // ACCESS_CONTROL_O: "*",
      // ACCESS_CONTROL_H: "*"
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      contentType: APPLICATION_JSON,
      // receiveTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      // sendTimeout: const Duration(milliseconds: Constants.apiTimeOut),
    );

    //! Logs interceptor for network requests logging
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true),
      );
    }

    return dio;
  }
}
