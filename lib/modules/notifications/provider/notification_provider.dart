import 'package:ared/modules/auth/models/response/user_model.dart';
import 'package:ared/modules/base_structure/repositories/base_repository.dart';
import 'package:ared/modules/notifications/repositories/notification_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/services/error/failure.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _notificationRepository;

  NotificationProvider(this._notificationRepository);

  bool isLoading = false;
  
  Failure? failure;
  User? data;
  Future<void> getSomething( ) async {
     isLoading = true;
    notifyListeners();
    final result = await _notificationRepository.getSomething();
    isLoading = false;
    notifyListeners();
    result.fold((l) => failure = l, (r) => data = r);
    
  }

}
