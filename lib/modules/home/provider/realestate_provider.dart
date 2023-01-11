import 'package:ared/modules/home/repositories/add_realestate_appraisal_repository.dart';
import 'package:flutter/material.dart';

class RealestateProvider extends ChangeNotifier {
  final AddRealestateAppraisalRepository _addRealestateAppraisalRepository;

  RealestateProvider(this._addRealestateAppraisalRepository);

  int? offerId;

  Future<void> sendRequest() async {
    notifyListeners();
    final result = await _addRealestateAppraisalRepository.sendRequest(offerId ?? 1);
    notifyListeners();
  }

  Future<void> sendReport({
    required String email,
    required String name,
    required String comment,
  }) async {
    notifyListeners();
    final result = await _addRealestateAppraisalRepository.sendReport(
      comment: email,
      email: name,
      name: comment,
    );
    notifyListeners();
  }


}
