import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> networkHeaderSetup(bool requireAuth) async {
  String? token = "f4o_Z3Cu_PMryLZjUmMNaoDUMjEF9yidsLUqR9hqAEeR-1m99RtHe2G8YI7F4gjV";

  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(responseBody: false));
  // dio.interceptors.add(LogInterceptor(responseBody: true));
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return null;
  };

  dio.options.connectTimeout = 20000;
  dio.options.headers['Accept'] = '*/*';
  dio.options.headers['appKey'] = '3/T3&2,TSFX*qPG,j^r\$';
  dio.options.headers["authorization"] = "Bearer $token";

  if (requireAuth) {
    if (token == null) {
      return Future.error('auth');
    }
  }

  // kEcho('dio header token-> $token');

  return dio;
}

String networkHandleError(DioError error) {
  // switch (error.type) {
  //   case DioErrorType.connectTimeout:
  //     break;
  //   case DioErrorType.receiveTimeout:
  //     break;
  //   case DioErrorType.sendTimeout:
  //     break;
  //   case DioErrorType.response:
  //     break;
  //   case DioErrorType.cancel:
  //     break;
  //   default:
  //     break;
  // }

  if (error.response != null && error.response!.statusCode != null && error.response!.statusCode == 400) {
    return 'server';
  }
  if (error.response != null && error.response!.statusCode != null && error.response!.statusCode == 401) return 'auth';
  if (error.response != null && error.response!.statusCode != null && error.response!.statusCode == 500) return 'server';

  return 'network';
}
