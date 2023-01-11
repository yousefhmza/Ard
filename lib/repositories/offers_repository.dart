import 'package:ared/core/network/models/basic_response.dart';
import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/models/responses/my_offers_response.dart';

class OffersRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;

  OffersRepository(this._apiConsumer, this._networkInfo);

  Future<List<OfferItem>> getMyOffers() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.get(url: EndPoints.myOffersList /*EndPoints. */);
        MyOffersResponse myOffersResponse = MyOffersResponse.fromJson(response.data);
        return myOffersResponse.item;
      } on Exception catch (e) {
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }
  Future<List<OfferItem>> getAllOffers() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.get(url: EndPoints.offersList /*EndPoints. */);
        MyOffersResponse myOffersResponse = MyOffersResponse.fromJson(response.data);
        return myOffersResponse.item;
      } on Exception catch (e) {
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<bool> offerRenew(String id) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> queryParameters = {"id": id};
      try {
        final response = await _apiConsumer.get(url: EndPoints.offerRenew, queryParameters: queryParameters);
        BasicResponse basicResponse = BasicResponse.fromJson(response.data);
        if (basicResponse.success)
          return true;
        else
          return Future.error(Failure(200, basicResponse.message));
      } on Exception catch (e) {
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }
  
  Future<bool> offerDelete(String id) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> queryParameters = {"id": id};
      try {
        final response = await _apiConsumer.get(url: EndPoints.offerDelete, queryParameters: queryParameters);
        BasicResponse basicResponse = BasicResponse.fromJson(response.data);
        if (basicResponse.success)
          return true;
        else
          return Future.error(Failure(200, basicResponse.message));
      } on Exception catch (e) {
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }
  
  Future<bool> offerChangeStatus(String id) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> queryParameters = {"id": id};
      try {
        final response = await _apiConsumer.get(url: EndPoints.offerChangeStatus, queryParameters: queryParameters);
        BasicResponse basicResponse = BasicResponse.fromJson(response.data);
        if (basicResponse.success)
          return true;
        else
          return Future.error(Failure(200, basicResponse.message));
      } on Exception catch (e) {
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<bool> offerViewCount(String id) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> queryParameters = {"offer_id": id};
      try {
        final response = await _apiConsumer.get(url: EndPoints.offerViewCount, queryParameters: queryParameters);
        BasicResponse basicResponse = BasicResponse.fromJson(response.data);
        if (basicResponse.success)
          return true;
        else
          return Future.error(Failure(200, basicResponse.message));
      } on Exception catch (e) {
        return Future.error(ErrorHandler.handle(e).failure);
      }
    } else {
      return Future.error(ErrorType.noInternetConnection.getFailure());
    }
  }

}
