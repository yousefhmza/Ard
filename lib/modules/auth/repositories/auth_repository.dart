import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/local/cache_consumer.dart';
import 'package:ared/core/services/local/storage_keys.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/modules/auth/models/request/login_body.dart';
import 'package:ared/modules/auth/models/request/registration_body.dart';
import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;
  final CacheConsumer _cacheConsumer;

  AuthRepository(this._apiConsumer, this._networkInfo, this._cacheConsumer);

  Future<Either<Failure, String>> updateOtp(String phoneNumber) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.post(url: EndPoints.updateOtp, requestBody: {"mobile": phoneNumber});
        return Right(response.data["item"]["otp"]);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, String>> register(RegistrationBody registrationBody) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.post(url: EndPoints.register, requestBody: registrationBody.toJson());
        return Right(response.data["item"]["otp"]);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, User>> login(LoginBody loginBody) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.post(url: EndPoints.login, requestBody: loginBody.toJson());
        await _cacheConsumer.saveSecuredData(StorageKeys.token, response.data["item"]["token"]);
        await _cacheConsumer.save(StorageKeys.isAuthed, true);
        return Right(User.fromJson(response.data["item"]));
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, String>> logout() async {
    try {
      await _cacheConsumer.deleteSecuredData();
      await _cacheConsumer.delete(StorageKeys.isAuthed);
      return const Right(AppStrings.logoutSuccess);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
