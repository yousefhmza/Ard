import 'package:ared/modules/auth/repositories/auth_repository.dart';
import 'package:ared/modules/auth/repositories/social_auth_repository.dart';
import 'package:flutter/material.dart';

class SocialAuthAuthProvider extends ChangeNotifier {
  final SocialAuthRepository _socialAuthRepository;

  SocialAuthAuthProvider(this._socialAuthRepository);
}
