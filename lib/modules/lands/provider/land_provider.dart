import 'package:ared/core/utils/echo.dart';
import 'package:ared/modules/lands/models/lands_list_response.dart';
import 'package:ared/modules/lands/repositories/land_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class LandProvider extends ChangeNotifier {
  final LandRepository _repo;
  LandProvider(this._repo);

  bool isLoading = false;
  Failure? failure;

  LandItem landItem = LandItem();

  Future<LandItem> getLandDetails(int landId) async {
    isLoading = true;
    notifyListeners();
    try {
      notifyListeners();
      LandItem result = await _repo.getLand(landId);
      landItem = result;
      return result;
    } catch (e) {
      kEchoError('error $e');
      failure = Failure(200, e.toString());
    }
    isLoading = false;
    notifyListeners();
    return Future.error(failure?.message ?? "");
  }

  void init() {
    //clear all data
    isLoading = false;
    failure = null;
  }

  void refresh() {
    notifyListeners();
  }
}
