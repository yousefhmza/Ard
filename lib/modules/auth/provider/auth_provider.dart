import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/auth/models/request/login_body.dart';
import 'package:ared/modules/auth/models/request/registration_body.dart';
import 'package:ared/modules/auth/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';
import '../models/response/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  bool isLoading = false;
  bool isOtpLengthValid = false;

  LoginBody loginBody = LoginBody();
  RegistrationBody registrationBody = RegistrationBody();

  Future<Either<Failure, String>> updateOtp(String phoneNumber) async {
    isLoading = true;
    notifyListeners();
    final result = await _authRepository.updateOtp(phoneNumber);
    return result.fold(
      (failure) {
        isLoading = false;
        notifyListeners();
        return Left(failure);
      },
      (otp) {
        isLoading = false;
        notifyListeners();
        return Right(otp);
      },
    );
    
  }

  Future<Either<Failure, String>> register() async {
    isLoading = true;
    notifyListeners();
    final result = await _authRepository.register(registrationBody);
    return result.fold(
      (failure) {
        isLoading = false;
        notifyListeners();
        return Left(failure);
      },
      (otp) {
        isLoading = false;
        notifyListeners();
        return Right(otp);
      },
    );
  }

  Future<Either<Failure, User>> login() async {
    isLoading = true;
    notifyListeners();
    final result = await _authRepository.login(loginBody);
    return result.fold(
      (failure) {
        isLoading = false;
        notifyListeners();
        return Left(failure);
      },
      (user) {
        isLoading = false;
        currentUser = user;
        notifyListeners();
        return Right(user);
      },
    );
  }

  Future<Either<Failure, String>> logout() async {
    final result = await _authRepository.logout();
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (message) {
        currentUser = null;
        return Right(message);
      },
    );
  }

  void setOtpLengthValidity(bool isValid) {
    isOtpLengthValid = isValid;
    notifyListeners();
  }
}
