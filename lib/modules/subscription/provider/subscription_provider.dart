import 'dart:io';

import 'package:ared/core/utils/alerts.dart';
import 'package:ared/modules/subscription/model/subscription_info_response.dart';
import 'package:ared/modules/subscription/repositories/subscription_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class SubscriptionProvider extends ChangeNotifier {
  final SubscriptionRepository _baseRepository;
  SubscriptionProvider(this._baseRepository);

  bool isLoading = false;
  bool sendBandTransferImageLoading = false;
  File? transferImage;
  Failure? failure;
  SubscriptionInfo? subscriptionInfo;

  Future<void> getSubscriptionInfo() async {
    if (subscriptionInfo != null) return;
    isLoading = true;
    notifyListeners();
    Either<Failure, SubscriptionInfo> result = await _baseRepository.getSubscriptionInfo();
    isLoading = false;
    notifyListeners();
    result.fold((l) => failure = l, (r) => subscriptionInfo = r);
  }

  Future<bool> sendSubscriptionImage() async {
    if (transferImage == null) return false;
    sendBandTransferImageLoading = true;
    notifyListeners();
    final result = await _baseRepository.sendSubscriptionImage(transferImage!);
    sendBandTransferImageLoading = false;
    notifyListeners();
    return result.fold((l) {
      Alerts.showToast(l.message);
      return false;
    }, (r) {
      return true;
    });
  }
}
