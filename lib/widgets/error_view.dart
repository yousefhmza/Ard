import 'package:ared/core/services/error/failure.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/server_error.dart';
import 'package:flutter/material.dart';

import 'general_error.dart';

class ErrorView extends StatelessWidget {
  final Failure failure;
  final Function refresh;
  const ErrorView({super.key, required this.failure, required this.refresh});

  @override
  Widget build(BuildContext context) {
    if (failure.statusCode == 405) return ServerErrorWidget(refresh: () => refresh());
    if (failure.statusCode == 401) return AuthErrorWidget(action: () => refresh());

    return GeneralErrorWidget(refresh: () => refresh());
  }
}
