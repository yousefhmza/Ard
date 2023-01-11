import 'package:ared/core/network/models/basic_response.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/offers/models/offer_attributes_response.dart';
import 'package:ared/modules/offers/models/request/add_offer_body.dart';
import 'package:ared/modules/offers/repositories/add_offer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class AddOfferProvider extends ChangeNotifier {
  final AddOfferRepository _addOfferRepository;

  AddOfferProvider(this._addOfferRepository);

  bool isLoading = false;
  bool checkIfCanAddOfferLoading = false;
  int currentStep = 0;
  bool? licenceNumberStatus;
  AddOfferBody addOfferBody = AddOfferBody(services: []);

  Future<Either<Failure, BasicResponse>> addOffer() async {
    isLoading = true;
    notifyListeners();
    final result = await _addOfferRepository.addOffer(addOfferBody);
    return result.fold(
      (failure) {
        isLoading = false;
        notifyListeners();
        return Left(failure);
      },
      (message) {
        isLoading = false;
        notifyListeners();
        return Right(message);
      },
    );
  }

  Future<bool> checkLicenceNumberStatus() async {
    if (licenceNumberStatus != null && licenceNumberStatus!) return licenceNumberStatus!;
    checkIfCanAddOfferLoading = true;
    Either<Failure, User> result = await _addOfferRepository.checkIfCanAddOffer();
    checkIfCanAddOfferLoading = false;
    result.fold((l) => licenceNumberStatus = false, (r) {
      if (r.licenseNumber.isNotEmpty)
        licenceNumberStatus = true;
      else
        licenceNumberStatus = false;
    });
    return licenceNumberStatus!;
  }

  void setCurrentStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  bool offerAttributesLoading = true;
  OfferAttributes? offerAttributes;
  Failure? getOfferAttributesFailure;

  Future<void> getOfferAttributes() async {
    getOfferAttributesFailure = null;
    if (offerAttributes != null) return;
    try {
      offerAttributesLoading = true;
      notify();
      Either<Failure, OfferAttributes> result = await _addOfferRepository.getOfferAttributes();
      result.fold((l) => offerAttributes = null, (r) {
        offerAttributes = r;
      });
    } catch (e) {
      kEchoError('error $e');
      getOfferAttributesFailure = Failure(200, '$e');
    }
    offerAttributesLoading = false;
    notify();
  }

  void notify() => notifyListeners();
}
