import 'package:flutter/material.dart';

import '../../core/resources/resources.dart';

class NavigationSlideTransition extends PageRouteBuilder {
  final Widget screen;
  final Duration duration;
  final bool fromStartToEnd;

  NavigationSlideTransition({required this.screen, this.duration = Time.t300, this.fromStartToEnd = true})
      : super(
          pageBuilder: (_, __, ___) => screen,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (_, animation, __, child) {
            final Tween<Offset> tween = Tween<Offset>(
              begin: Offset(fromStartToEnd ? 1 : -1, 0),
              end: const Offset(0, 0),
            );
            final animationCurve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final slideAnimation = tween.animate(animationCurve);
            return SlideTransition(position: slideAnimation, child: child);
          },
        );
}

class NavigationUpwardSlideTransition extends PageRouteBuilder {
  final Widget screen;
  final Duration duration;

  NavigationUpwardSlideTransition({required this.screen, this.duration = Time.t300})
      : super(
          pageBuilder: (_, __, ___) => screen,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (_, animation, __, child) {
            final Tween<Offset> offsetTween = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0));
            final Tween<double> opacityTween = Tween<double>(begin: 0, end: 1);
            final animationCurve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final slideAnimation = offsetTween.animate(animationCurve);
            final fadeAnimation = opacityTween.animate(animationCurve);
            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        );
}
