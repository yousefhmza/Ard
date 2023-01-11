import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/base_structure/repositories/base_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class BaseProvider extends ChangeNotifier {
  final BaseRepository _baseRepository;

  BaseProvider(this._baseRepository);

  bool isLoading = false;

  Failure? failure;
  User? data;
  Future<void> getSomething( ) async {
     isLoading = true;
    notifyListeners();
    final result = await _baseRepository.getSomething();
    isLoading = false;
    notifyListeners();
    result.fold((l) => failure = l, (r) => data = r);
    
  }

}
