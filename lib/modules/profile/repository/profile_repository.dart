import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/profile/models/response/profile_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;

  ProfileRepository(this._apiConsumer, this._networkInfo);

  Future<Either<Failure, ProfileResponse>> getProfile() async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Response response = await _apiConsumer.get(url: EndPoints.profile);
        ProfileResponse profileResponse = ProfileResponse.fromJson(response.data);
        currentUser = profileResponse.user; 
        return Right(profileResponse);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, String>> updateProfile(User user) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic> queryParameters = {};
      queryParameters['mobile'] = user.mobileNumber;
      queryParameters['name'] = user.name;
      queryParameters['email'] = user.email;
      queryParameters['id_type'] = user.idType;
      queryParameters['id_number'] = user.idNumber;
      queryParameters['license_number'] = user.licenseNumber;
      if (kDebugMode) {
        queryParameters.forEach((key, value) {
          kEcho('updateProfile$key->$value');
        });
      }

      try {
        Response response = await _apiConsumer.post(url: EndPoints.updateProfile, requestBody: null, queryParameters: queryParameters);
        return Right(response.data['message'].toString());
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
