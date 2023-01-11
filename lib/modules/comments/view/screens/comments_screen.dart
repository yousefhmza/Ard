import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/comments/provider/comments_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/num_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';
import '../../../../modules/comments/view/components/write_comment_component.dart';
import '../../../../modules/comments/view/widgets/comment_widget.dart';

class CommentsScreen extends StatelessWidget {
  final int offerId;
  const CommentsScreen({required this.offerId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentsProvider commentsProvider = Provider.of<CommentsProvider>(context, listen: false);
    commentsProvider.offerId = offerId;
    commentsProvider.getRatesAndComments();

    return Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: const MainAppbar(title: AppStrings.comments),
        body: Consumer<CommentsProvider>(
          builder: (context, provderData, child) {
            if (commentsProvider.isLoading) return const LoadingSpinner();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppPadding.p16.w),
                  child: CustomText(
                    "${AppStrings.comments} (${provderData.comments.length})",
                    color: AppColors.pink,
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: provderData.comments.length,
                    itemBuilder: (context, index) => CommentWidget(provderData.comments[index]),
                    separatorBuilder: (context, index) => VerticalSpace(AppSize.s16.h),
                  ),
                ),
                VerticalSpace(AppSize.s8.h),
                if (currentUser == null) const Center(child: CustomText(AppStrings.toAddCommentAndRateYouNeedToLoginOrRegister,color: Colors.grey,)),
                if (currentUser != null) const WriteCommentComponent(),
                const SizedBox(height: 12),
             ],
            );
          },
        ));
  }
}
