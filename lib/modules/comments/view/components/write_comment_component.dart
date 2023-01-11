import 'package:ared/modules/comments/provider/comments_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class WriteCommentComponent extends StatefulWidget {
  const WriteCommentComponent({Key? key}) : super(key: key);

  @override
  State<WriteCommentComponent> createState() => _WriteCommentComponentState();
}

class _WriteCommentComponentState extends State<WriteCommentComponent> {
  @override
  Widget build(BuildContext context) {
    final CommentsProvider commentsProvider = Provider.of<CommentsProvider>(context, listen: false);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p16.w),
      margin: EdgeInsets.all(AppPadding.p16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
            child: const CustomText(
              AppStrings.addComment,
              color: AppColors.pink,
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Container(
            key: GlobalKey(),
            child: RatingBar.builder(
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: AppColors.lightGrey,
              glowColor: Colors.amber,
              itemSize: AppSize.s32,
              onRatingUpdate: (double rating) {
                commentsProvider.myComment.rate = rating;
              },
              itemBuilder: (context, _) => const CustomIcon(Icons.star, color: AppColors.yellow),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  minLines: 1,
                  controller: commentsProvider.myCommentController,
                  maxLines: 3,
                  cursorColor: AppColors.primary,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontFamily: FontConstants.englishFontFamily,
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeightManager.regular,
                  ),
                  decoration: const InputDecoration(
                    hintText: AppStrings.writeYourComment,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    commentsProvider.myComment.comment = value;
                  },
                ),
              ),
              HorizontalSpace(AppSize.s16.w),
              Consumer<CommentsProvider>(
                builder: (context, value, child) {
                  if (value.isLoadingAddComment) return const LoadingSpinner();
                  return GestureDetector(
                      onTap: () async {
                        await commentsProvider.addComment();
                        setState(() {});
                      },
                      child: const CustomIcon(Icons.send, color: Colors.pink));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
