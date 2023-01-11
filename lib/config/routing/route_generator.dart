import 'package:ared/modules/auth/view/screens/auth_screen.dart';
import 'package:ared/modules/home/view/components/map_interactive.dart';
import 'package:ared/modules/lands/view/screens/land_screen.dart';
import 'package:ared/modules/lands/view/screens/lands_screen.dart';
import 'package:ared/modules/lands/view/screens/request_land_screen.dart';
import 'package:ared/modules/offers/view/screens/my_offer_details.dart';
import 'package:ared/modules/offers/view/screens/my_offers_screen.dart';
import 'package:ared/modules/subscription/view/screens/payment_methods.dart';
import 'package:ared/modules/subscription/view/screens/subscription_screen.dart';
import 'package:ared/modules/subscription/view/screens/transfer_info_screen.dart';
import 'package:flutter/material.dart';

import '../../core/view/screens/undefined_route_screen.dart';
import '../../modules/auth/view/screens/otp_screen.dart';
import '../../modules/auth/view/screens/phone_number_screen.dart';
import '../../modules/auth/view/screens/signup_screen.dart';
import '../../modules/comments/view/screens/comments_screen.dart';
import '../../modules/layout/view/screens/layout_screen.dart';
import '../../modules/map_specs/view/screens/map_specs_screen.dart';
import '../../modules/offers/view/screens/add_offer_screen.dart';
import '../../modules/profile/view/screens/profile_screen.dart';
import '../../modules/search/view/screens/search_screen.dart';
import '../../modules/splash/view/screens/splash_screen.dart';
import 'navigation_transition.dart';
import 'platform_page_route.dart';
import 'routes.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen());
      case Routes.authScreen:
        return platformPageRoute(const AuthScreen());
      case Routes.interactiveMap:
        return platformPageRoute(const InteractiveMap(interactiveMapParams: null));
      case Routes.phoneNumberScreen:
        return platformPageRoute(PhoneNumberScreen());
      case Routes.signupScreen:
        return platformPageRoute(SignupScreen());
      case Routes.otpScreen:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return NavigationSlideTransition(
          screen: OTPScreen(phoneNumber: arguments["phone_number"], requiredOtp: arguments["required_otp"]),
        );
      case Routes.layoutScreen:
        return platformPageRoute(const LayoutScreen());
      case Routes.addOfferScreen:
        return NavigationUpwardSlideTransition(screen: const AddOfferScreen());
      case Routes.searchScreen:
        return NavigationSlideTransition(screen: const SearchScreen());
      case Routes.mapSpecsScreen:
        return NavigationSlideTransition(screen: const MapSpecsScreen(), fromStartToEnd: false);
      case Routes.commentsScreen:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(CommentsScreen(offerId: arguments['id']));
      case Routes.singleLandScreen:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(LandScreen(landItem: arguments["land_item"]));
      case Routes.profileScreen:
        return platformPageRoute(const ProfileScreen());
      case Routes.subscriptionScreen:
        return platformPageRoute(const SubscriptionScreen());
      case Routes.landRequestsScreen:
        return platformPageRoute(const LandsScreen());
      case Routes.myOffers:
        return platformPageRoute(const MyOffersScreen());
      case Routes.paymentMethodScreen:
        return platformPageRoute(const PaymentMethodsScreen());
      case Routes.transferInfoScreen:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(TransferInfoScreen(subscription: arguments["subscription"]));
      case Routes.requestLandScreen:
        return platformPageRoute(const RequestLandScreen());
      case Routes.myOfferDetails:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return platformPageRoute(MyOfferDetails(offerItem: arguments["offerItem"]));
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
