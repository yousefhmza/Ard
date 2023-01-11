import 'package:ared/core/resources/resources.dart';
import 'package:ared/core/utils/alerts.dart';
import 'package:ared/modules/lands/view/screens/request_land_screen.dart';
import 'package:flutter/material.dart';

import '../../offers/view/screens/available_lands_screen.dart';
import '../../../modules/home/view/screens/home_screen.dart';
import '../../../modules/more/view/screens/more_screen.dart';
import '../../../modules/notifications/view/screens/notifications_screen.dart';
import '../../../modules/offers/view/screens/offers_screen.dart';

class LayoutProvider extends ChangeNotifier {
  int currentScreenIndex = 0;
  final PageController pageController = PageController();
  final List<Widget> screens =  [
    HomeScreen(),
    OffersScreen(),
    RequestLandScreen(),
    AvailableLandsScreen(),
    NotificationsScreen(),
    MoreScreen(),
  ];

  void setCurrentIndex(int index) {
    if(index == -1){
      Alerts.showToast(AppStrings.soon);
      return;
    }
    pageController.jumpToPage(index);
    currentScreenIndex = index;
    notifyListeners();
  }
}
