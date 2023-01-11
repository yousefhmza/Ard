import 'dart:io';

import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/core/view/app_views.dart';
import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/profile/models/response/profile_response.dart';
import 'package:ared/modules/profile/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/error/failure.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _profileRepository;

  ProfileProvider(this._profileRepository);

  bool isLoading = false;
  bool isLoadingUpdate = false;
  bool enableEditing = false;
  Failure? failure;
  User? userData;

  Future<ProfileResponse?> getProfile() async {
    ProfileResponse? userDataWithSubscription;
    isLoading = true;
    notifyListeners();
    Either<Failure, ProfileResponse> result = await _profileRepository.getProfile();
    isLoading = false;
    result.fold((l) => failure = l, (r){
      userData = r.user;
      userDataWithSubscription = r;
    });
    notifyListeners();
    return userDataWithSubscription;
  }

  Future<void> updateProfile(BuildContext context) async {
    if (userData == null) return;
    isLoadingUpdate = true;
    notifyListeners();
    Either<Failure, String> result = await _profileRepository.updateProfile(userData!);
    isLoadingUpdate = false;
    notifyListeners();
    result.fold(
      (failure) => Alerts.showSnackBar(context, failure.message),
      (message) {
        Alerts.showToast(message);
      },
    );
  }

  void switchEnableEditing(bool value) {
    enableEditing = value;
    notifyListeners();
  }

  pickImage(BuildContext context) async {
    //show dialog to pick image
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          color: Colors.red,
          child: Container(
            color: Colors.white,
            height: 25.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      PickedFile? pickedFile = await (ImagePicker().getImage(source: ImageSource.camera, imageQuality: 25));

                      if (pickedFile != null) {
                        File file = File(pickedFile.path);
                        userData!.image = file.path;
                        userData!.imageAsFile = file;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt, color: Colors.grey[500]),
                          SizedBox(width: 8),
                          Expanded(child: CustomText(AppStrings.openCamera, color: Colors.grey[500])),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      PickedFile? pickedFile = await (ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 25));

                      if (pickedFile != null) {
                        File file = File(pickedFile.path);
                        userData!.image = file.path;
                        userData!.imageAsFile = file;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.image, color: Colors.grey[500]),
                          SizedBox(width: 8),
                          Expanded(child: CustomText(AppStrings.selectPhoto, color: Colors.grey[500])),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
