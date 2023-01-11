import 'package:ared/modules/comments/models/response/comments_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class CommentWidget extends StatelessWidget {
  final SingleComment comment;
  const CommentWidget(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               CustomText("${comment.userName}", fontWeight: FontWeightManager.bold),
              RatingBar.builder(
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                glowColor: Colors.amber,
                unratedColor: AppColors.lightGrey,
                itemSize: AppSize.s20,
                initialRating: comment.rate ?? 0,
                onRatingUpdate: (rating) {},
                itemBuilder: (context, _) => const CustomIcon(Icons.star, color: AppColors.yellow),
              ),
            ],
          ),
           CustomText("${comment.comment}")
        ],
      ),
    );
  }
}
