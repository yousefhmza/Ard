import 'dart:convert';

import 'package:ared/core/network/repository/area_feature_info_response.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xml2json/xml2json.dart';

import 'network_setup.dart';

Future<Uint8List> networkGetMapImageLayer({
  required String bBox,
  required String height,
  required String width,
}) async {
  Dio dio = await networkHeaderSetup(false);
  Map<String, dynamic> queryParameters = {};
  queryParameters['SERVICE'] = "WMS";
  queryParameters['VERSION'] = "1.3.0";
  queryParameters['REQUEST'] = "GetMap";
  queryParameters['BBOX'] = bBox;
  queryParameters['CRS'] = "CRS:84";
  queryParameters['WIDTH'] = width;
  queryParameters['HEIGHT'] = height;
  queryParameters['LAYERS'] = "1";
  queryParameters['FORMAT'] = "image/png";
  queryParameters['DPI'] = "72";
  queryParameters['STYLES'] = "";
  queryParameters['MAP_RESOLUTION'] = "72";
  queryParameters['FORMAT_OPTIONS'] = "dpi:72";
  queryParameters['TRANSPARENT'] = "TRUE";
  String url = "https://geoportal.gasgi.gov.sa/ogc/services/CO/ruwad1103/MapServer/WMSServer";
  try {
    Response dioResponse = await dio.get(url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.bytes,
        ));

    if (dioResponse.statusCode == 200) {
      Uint8List ss = dioResponse.data;
      return ss;
      return Future.error('error');
      // BasicResponse dateResponse = BasicResponse.fromJson(dioResponse.data);
      // if (dateResponse.success == 'true') {
      //   return '';
      // } else
      //   return Future.error(dateResponse.message);
    } else {
      return Future.error('server');
    }
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  }
}

Future<FeatureInfoResponse?> networkGetAreaInfo({required String bBox}) async {
  Dio dio = await networkHeaderSetup(false);
  Map<String, dynamic> queryParameters = {};
  queryParameters['SERVICE'] = "WMS";
  queryParameters['VERSION'] = "1.3.0";
  queryParameters['REQUEST'] = "GetFeatureInfo";
  queryParameters['BBOX'] = bBox;
  queryParameters['CRS'] = "CRS:84";
  queryParameters['WIDTH'] = "1";
  queryParameters['HEIGHT'] = "1";
  queryParameters['LAYERS'] = "1";
  queryParameters['FORMAT'] = "image/png";
  queryParameters['DPI'] = "72";
  queryParameters['STYLES'] = "";
  queryParameters['INFO_FORMAT'] = "text/xml";
  queryParameters['QUERY_LAYERS'] = "1";
  queryParameters['MAP_RESOLUTION'] = "72";
  queryParameters['FORMAT_OPTIONS'] = "dpi:72";
  queryParameters['TRANSPARENT'] = "TRUE";
  queryParameters['I'] = "0";
  queryParameters['J'] = "1";
  String url = "https://geoportal.gasgi.gov.sa/ogc/services/CO/ruwad1103/MapServer/WMSServer";

  try {
    Response dioResponse = await dio.get(url, queryParameters: queryParameters);

    if (dioResponse.statusCode == 200) {
      final myTransformer = Xml2Json();

      // Parse a simple XML string

      myTransformer.parse(dioResponse.data);
      String string = myTransformer.toBadgerfish();
      AreaFeatureInfoResponse areaFeatureInfoResponse = AreaFeatureInfoResponse.fromJson(jsonDecode(string));

      kEcho('-- ${areaFeatureInfoResponse.featureInfoResponse!.OBJECTID}');
      return areaFeatureInfoResponse.featureInfoResponse;
    } else {
      return Future.error('server');
    }
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  } catch (e) {
    kEchoError('error $e');
  }
  return null;
}
