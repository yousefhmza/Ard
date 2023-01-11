  import 'package:ared/core/services/error/error_handler.dart';
  import 'package:ared/core/services/error/failure.dart';
  import 'package:ared/core/services/local/cache_consumer.dart';
  import 'package:ared/core/services/network/api_consumer.dart';
  import 'package:ared/core/services/network/network_info.dart';
  import 'package:ared/modules/auth/models/response/user_model.dart';
  import 'package:dartz/dartz.dart';

  class BaseRepository {
    final NetworkInfo _networkInfo;
    final ApiConsumer _apiConsumer;
    final CacheConsumer _cacheConsumer;

    BaseRepository(this._apiConsumer, this._networkInfo, this._cacheConsumer);

    Future<Either<Failure, User>> getSomething() async {
      final bool hasConnection = await _networkInfo.hasConnection;
      if (hasConnection) {
        try {
          final response = await _apiConsumer.get(url: '' /*EndPoints. */);
          return Right(response.data["item"]["otp"]);
        } on Exception catch (e) {
          return Left(ErrorHandler.handle(e).failure);
        }
      } else {
        return Left(ErrorType.noInternetConnection.getFailure());
      }
    }

  }
