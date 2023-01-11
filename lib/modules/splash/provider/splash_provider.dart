import 'package:ared/modules/splash/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';
import '../../../core/utils/globals.dart';
import '../../auth/models/response/user_model.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepository _splashRepository;

  SplashProvider(this._splashRepository);

  bool isLoading = false;

  bool get isAuthed => _splashRepository.isAuthed;

  Future<Either<Failure, User>> getCurrentUser() async {
    isLoading = true;
    notifyListeners();
    final result = await _splashRepository.getCurrentUser();
    return result.fold(
      (failure) {
        isLoading = false;
        notifyListeners();
        return Left(failure);
      },
      (user) {
        currentUser = user;
        isLoading = false;
        notifyListeners();
        return Right(user);
      },
    );
  }
}
