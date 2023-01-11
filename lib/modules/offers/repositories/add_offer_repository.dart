import 'package:ared/core/network/models/basic_response.dart';
import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/offers/models/offer_attributes_response.dart';
import 'package:ared/modules/offers/models/request/add_offer_body.dart';
import 'package:ared/modules/profile/models/response/profile_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/endpoints.dart';

class AddOfferRepository {
  final ApiConsumer _apiConsumer;
  final NetworkInfo _networkInfo;

  AddOfferRepository(this._apiConsumer, this._networkInfo);

  Future<Either<Failure, BasicResponse>> addOffer(AddOfferBody addOfferBody) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Response response =  await _apiConsumer.post(url: EndPoints.addOffer, requestBody: addOfferBody.toFormData());
        BasicResponse basicResponse = BasicResponse.fromJson(response.data);
        return  Right(basicResponse);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, User>> checkIfCanAddOffer() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Response response = await _apiConsumer.get(url: EndPoints.profile);
        ProfileResponse profileResponse = ProfileResponse.fromJson(response.data);
        return Right(profileResponse.user);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

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
}
