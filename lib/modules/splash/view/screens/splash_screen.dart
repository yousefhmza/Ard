import 'dart:async';

import 'package:ared/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ared/modules/splash/provider/splash_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../config/routing/routes.dart';
import '../../../../core/services/error/error_handler.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/widgets/status_bar.dart';
import '../../../../core/resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // late final AnimationController animationController;
  // late final Animation<double> animation;

  // @override
  // void initState() {
  //   super.initState();
  //   initAnimation();
  //   redirect();
  // }

  // void initAnimation() {
  //   animationController = AnimationController(vsync: this, duration: Time.t2000);
  //   CurvedAnimation animationCurve = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
  //   animation = Tween<double>(begin: 0, end: 1).animate(animationCurve);
  //   animationController.forward();
  // }

  // void redirect() {
  //   Future.delayed(
  //     animationController.duration! + Time.t1000,
  //     () => NavigationService.pushReplacement(context, Routes.authScreen),
  //   );
  // }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  late final SplashProvider splashProvider;
  StreamSubscription<ConnectivityResult>? _connectivityResult;

  @override
  void initState() {
    splashProvider = Provider.of<SplashProvider>(context, listen: false);
    Future.delayed(
      Time.t2000,
      () async {
        final result = await Connectivity().checkConnectivity();
        if (result != ConnectivityResult.none) {
          fetchAndRedirect();
        } else {
          Alerts.showToast(ErrorType.noInternetConnection.getFailure().message);
          _connectivityResult = Connectivity().onConnectivityChanged.listen((result) {
            bool isConnected = (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
            if (isConnected) {
              Alerts.showToast(AppStrings.connected);
              fetchAndRedirect();
            } else {
              Alerts.showToast(ErrorType.noInternetConnection.getFailure().message);
            }
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivityResult?.cancel();
  }

  Future<void> fetchAndRedirect() async {
    if (splashProvider.isAuthed) {
      final result = await splashProvider.getCurrentUser();
      result.fold(
        (failure) => NavigationService.pushReplacementAll(context, Routes.authScreen),
        //cancel require auth step
        // (failure) => Alerts.showActionSnackBar(
        //   context,
        //   message: failure.message,
        //   actionLabel: AppStrings.retry,
        //   onActionPressed: () => splashProvider.getCurrentUser(),
        // ),
        (user) => NavigationService.pushReplacementAll(context, Routes.layoutScreen),
      );
    } else {
      NavigationService.pushReplacementAll(context, Routes.authScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: Time.t2000,
                curve: Curves.easeInOut,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Image.asset(AppImages.logo, width: deviceWidth * 0.5),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<SplashProvider>(
                builder: (context, splashProvider, child) => splashProvider.isLoading
                    ? Padding(
                        padding: EdgeInsets.all(AppPadding.p16.w),
                        child: SizedBox(
                          width: AppSize.s24.r,
                          height: AppSize.s24.r,
                          child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: AppSize.s3.w),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
