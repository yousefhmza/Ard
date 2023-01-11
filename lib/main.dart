import 'package:ared/modules/auth/provider/auth_provider.dart';
import 'package:ared/modules/auth/provider/social_auth_provider.dart';
import 'package:ared/modules/comments/provider/comments_provider.dart';
import 'package:ared/modules/home/provider/realestate_provider.dart';
import 'package:ared/modules/lands/provider/land_provider.dart';
import 'package:ared/modules/lands/provider/lands_provider.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:ared/modules/map_specs/provider/map_specs_provider.dart';
import 'package:ared/modules/profile/provider/profile_provider.dart';
import 'package:ared/modules/splash/provider/splash_provider.dart';
import 'package:ared/modules/subscription/provider/subscription_provider.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'config/routing/navigation_services.dart';
import 'config/routing/route_generator.dart';
import 'config/routing/routes.dart';
import 'config/theme/app_theme.dart';
import 'di_container.dart' as di;
import 'modules/offers/providers/add_offer_provider.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(rp.ProviderScope(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<SocialAuthAuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<LayoutProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<AddOfferProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<MapSpecsProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<CommentsProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<RealestateProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<SubscriptionProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<LandsProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OffersProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<LandProvider>()),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ared",
      theme: appTheme(context),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      // temporary till localization
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
