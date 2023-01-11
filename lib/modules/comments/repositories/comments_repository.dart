import 'package:ared/core/services/error/error_handler.dart';
import 'package:ared/core/services/error/failure.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/endpoints.dart';
import 'package:ared/core/services/network/network_info.dart';
import 'package:ared/modules/comments/models/response/comments_response.dart';
import 'package:dartz/dartz.dart';

class CommentsRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;

  CommentsRepository(this._apiConsumer, this._networkInfo);

  Future<Either<Failure, List<SingleComment>>> getRatesAndComments(int? offerId) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await _apiConsumer.get(url: '${EndPoints.comments}?id=$offerId');
        CommentsResponse commentsResponse = CommentsResponse.fromJson(response.data);
        return Right(commentsResponse.comments);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> addRateAndComment(SingleComment myRateAndComment) async {
    final bool hasConnection = await _networkInfo.hasConnection;
    if (hasConnection) {
      Map<String, dynamic>? queryParameters = {};
      queryParameters['offer_id'] = myRateAndComment.offerId;
      queryParameters['comment'] = myRateAndComment.comment;
      queryParameters['rate'] = myRateAndComment.rate;
      try {
        final response = await _apiConsumer.post(url: EndPoints.addComment, requestBody: null, queryParameters: queryParameters);
        return const Right(true);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}
