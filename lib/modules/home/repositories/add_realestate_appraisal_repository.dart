import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/modules/home/response/realestate_apprisal_response.dart';
import 'package:dartz/dartz.dart';

class AddRealestateAppraisalRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;

  AddRealestateAppraisalRepository(this._apiConsumer, this._networkInfo);

  Future<Either<Failure, Item>> sendRequest(int? offerId) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Map<String, dynamic>? queryParameters = {};
        queryParameters['offer_id'] = offerId ?? 1;
        final res = await _apiConsumer.post(
          url: EndPoints.addRealestateAppraisal,
          queryParameters: queryParameters,
          requestBody: null,
        );
        RealestateAppraisalResponse response = RealestateAppraisalResponse.fromJson(res.data);
        return Right(response.item!);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> sendReport({
    required String email,
    required String name,
    required String comment,
  }) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        Map<String, dynamic>? queryParameters = {};
        queryParameters['email'] = email;
        queryParameters['name'] = name;
        queryParameters['comment'] = comment;

        final res = await _apiConsumer.post(
          url: EndPoints.sendReport,
          queryParameters: queryParameters,
          requestBody: null,
        );
        RealestateAppraisalResponse response = RealestateAppraisalResponse.fromJson(res.data);
        if (res.statusCode == 200 || res.statusCode == 201) return Right(true);
        return Right(false);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
