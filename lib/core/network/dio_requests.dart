import 'package:ared/core/utils/echo.dart';
import 'package:dio/dio.dart';

import 'network_setup.dart';

Future<Response> networkPost({
  required String url,
  Map<String, dynamic>? params,
  Map<String, dynamic>? data,
  FormData? formData,
  bool requiredAuth = false,
}) async {
  if (params != null) {
    params.forEach((key, value) {
      kEcho('$key: $value');
    });
  }
  if (data != null) {
    data.forEach((key, value) {
      kEcho('$key: $value');
    });
  }
  if (formData != null)
    for (var element in formData.fields) {
      kEcho('formData $element:');
    }
  Dio dio = await networkHeaderSetup(requiredAuth);

  try {
    Response response = await dio.post(url, queryParameters: params, data: data ?? formData ?? params);
    return response;
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  }
}
