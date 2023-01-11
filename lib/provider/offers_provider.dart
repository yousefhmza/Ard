import 'package:ared/core/resources/app_strings.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/models/responses/my_offers_response.dart';
import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/offers/models/offer_attributes_response.dart';
import 'package:ared/modules/offers/models/request/add_offer_body.dart';
import 'package:ared/modules/offers/repositories/add_offer_repository.dart';
import 'package:ared/repositories/offers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class OffersProvider extends ChangeNotifier {
  final OffersRepository offersRepository;

  OffersProvider(this.offersRepository) {
    kEcho('getMyOffers called');
  }
  bool isLoading = false;

  Failure? failure;
  List<OfferItem> offersList = [];
  List<OfferItem> myOffersList = [];

  Future<void> getMyOffers() async {
    isLoading = true;
    notifyListeners();
    try {
      offersList = await offersRepository.getMyOffers();
    } catch (e) {
      kEcho("getMyOffers: $e");
      if (e is Failure)
        failure = e;
      else
        failure = Failure(200, "unkown");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllOffers() async {
    isLoading = true;
    notifyListeners();
    try {
      offersList = await offersRepository.getAllOffers();
    } catch (e) {
      kEcho("getMyOffers: $e");
      if (e is Failure)
        failure = e;
      else
        failure = Failure(200, "unkown");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> deleteOffer(String id) async {
    try {
      bool status = await offersRepository.offerDelete(id);
      return status;
    } catch (e) {
      kEcho("delete offer : $e");
    }
    return false;
  }

  Future<bool> changeStatusOffer(String id) async {
    try {
      bool status = await offersRepository.offerChangeStatus(id);
      return status;
    } catch (e) {
      kEcho("delete offer : $e");
    }
    return false;
  }

  Future<String> offerRenew(String id) async {
    try {
      bool status = await offersRepository.offerRenew(id);
      return "";
    } catch (e) {
      if (e is Failure) kEcho("delete offer : ${e.message}");
      if (e is Failure) return e.message;
    }
    return AppStrings.somethingWentWrong;
  }

  Future<bool> offerViewCount(String id) async {
    try {
      bool status = await offersRepository.offerViewCount(id);
      return status;
    } catch (e) {
      if (e is Failure)
        kEcho("offerViewCount offer : ${e.message}");
      else
        kEcho("offerViewCount offer : $e");
    }
    return false;
  }
}
