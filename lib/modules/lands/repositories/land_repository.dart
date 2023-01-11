import 'package:ared/core/network/models/basic_response.dart';
import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/local/cache_consumer.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/modules/lands/models/cities_areas_response.dart';
import 'package:ared/modules/lands/models/land_request_model.dart';
import 'package:ared/modules/lands/models/lands_list_response.dart';
import 'package:ared/modules/lands/models/offer_attributes_response.dart';
import 'package:ared/modules/lands/models/single_land_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LandRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;
  final CacheConsumer _cacheConsumer;

  LandRepository(this._apiConsumer, this._networkInfo, this._cacheConsumer);

  Future<Either<Failure, OfferAttributes>> getOfferAttributes() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Response response = await _apiConsumer.get(url: EndPoints.getOfferAttributes);
        OfferAttributesResponse res = OfferAttributesResponse.fromJson(response.data);
        if (res.item == null) return Left(Failure(200, 'null'));
        return Right(res.item!);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, List<City>>> getCitiesAndAreas() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Response response = await _apiConsumer.get(url: EndPoints.getCitiesAndAreas);
        CityAreaResponse res = CityAreaResponse.fromJson(response.data);
        if (res.cities == null) return Left(Failure(200, 'null'));
        return Right(res.cities);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<String, String>> sendLandRequest(LandRequestModel landRequestModel) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> queryParameters = {};
      queryParameters['offer_type'] = landRequestModel.offerTypeId;
      queryParameters['city'] = landRequestModel.cityId;
      queryParameters['area'] = landRequestModel.areaId;
      queryParameters['district'] = landRequestModel.district;
      queryParameters['land_space'] = landRequestModel.landSpace;
      queryParameters['price'] = landRequestModel.price;
      queryParameters['contact_by'] = landRequestModel.contactBy;
      queryParameters['using'] = landRequestModel.usage!.contains("residential") ? "1" : "2";
      try {
        Response response = await _apiConsumer.post(url: EndPoints.sendLandRequest, requestBody: null, queryParameters: queryParameters);
        BasicResponse res = BasicResponse.fromJson(response.data);
        if (res.success) return Right(res.message);
        return Left(res.message);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure.message);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure().message);
    }
  }

  Future<List<LandItem>> getLands() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.get(url: EndPoints.landsList /*EndPoints. */);
        LandsListResponse landsListResponse = LandsListResponse.fromJson(response.data);
        return landsListResponse.landItem;
      } on Exception catch (e) {
        kEchoError(e.toString());
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<LandItem> getLand(int landId) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> params = {"land_id": landId};
      try {
        final response = await _apiConsumer.get(url: EndPoints.singleLand, queryParameters: params);
        SingleLandResponse landsListResponse = SingleLandResponse.fromJson(response.data);

        if (landsListResponse.item.isEmpty) return Future.error(Failure(200, landsListResponse.message));
        return landsListResponse.item.first;
      } on Exception catch (e) {
        kEchoError(e.toString());
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }
}
