import 'package:dio/dio.dart';

import 'network_setup.dart';

Future<Response> networkPost({
  required String url,
  required Map<String, dynamic> params,
  bool requiredAuth = false,
}) async {
  Dio dio = await networkHeaderSetup(requiredAuth);

  try {
    Response response = await dio.post(url, data: params);
    return response;
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  }
}

Future<Response> networkGet({
  required String url,
  required Map<String, dynamic> params,
  bool requiredAuth = false,
}) async {
  Dio dio = await networkHeaderSetup(requiredAuth);

  try {
    Response response = await dio.get(url, queryParameters: params);
    return response;
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  }
}
