import 'dart:io';

import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/local/cache_consumer.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/modules/subscription/model/subscription_info_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SubscriptionRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;
  final CacheConsumer _cacheConsumer;

  SubscriptionRepository(this._apiConsumer, this._networkInfo, this._cacheConsumer);

  Future<Either<Failure, SubscriptionInfo>> getSubscriptionInfo() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.get(url: EndPoints.subscription);
        SubscriptionResponse res = SubscriptionResponse.fromJson(response.data);
        return Right(res.item);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> sendSubscriptionImage(File image) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      //send image
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
      });
      try {
        final response = await _apiConsumer.post(url: EndPoints.sendBankTransferImage, requestBody: formData);
        return const Right(false);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
