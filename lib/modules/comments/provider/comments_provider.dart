import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/comments/models/response/comments_response.dart';
import 'package:ared/modules/comments/repositories/comments_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class CommentsProvider extends ChangeNotifier {
  final CommentsRepository _commentsRepository;

  CommentsProvider(this._commentsRepository);

  bool isLoading = false;
  bool isLoadingAddComment = false;
  int? offerId;
  SingleComment myComment = SingleComment(comment: '', rate: 0);
  TextEditingController myCommentController = TextEditingController();
  Failure? failure;
  List<SingleComment> comments = [];

  Future<void> getRatesAndComments() async {
    isLoading = true;
    notifyListeners();
    final result = await _commentsRepository.getRatesAndComments(offerId);
    isLoading = false;
    notifyListeners();
    result.fold((l) => failure = l, (r) => comments = r);
  }

  Future<void> addComment() async {
   
    FocusManager.instance.primaryFocus?.unfocus();
    if (myComment.comment == null || myComment.comment!.length < 2) {
      Alerts.showToast(AppStrings.writeYourComment);
      return;
    }
    if (myComment.rate == null || myComment.rate == 0) {
      Alerts.showToast(AppStrings.setYourRate);
      return;
    }

    myComment.offerId = offerId;
    myComment.userName = currentUser?.name ?? '';
    isLoadingAddComment = true;
    notifyListeners();
    final result = await _commentsRepository.addRateAndComment(myComment);
    isLoadingAddComment = false;
    // if (result.isRight()) comments.add(myComment);
    myComment.comment = '';
    myComment.rate = 0;
    myCommentController.clear();
    notifyListeners();
    Alerts.showToast("${AppStrings.successfullyAdd}\n${AppStrings.yourRateWillBeReviewed}");
  }
}
