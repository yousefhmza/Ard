import 'package:ared/modules/auth/provider/auth_provider.dart';
import 'package:ared/modules/auth/provider/social_auth_provider.dart';
import 'package:ared/modules/auth/repositories/auth_repository.dart';
import 'package:ared/modules/auth/repositories/social_auth_repository.dart';
import 'package:ared/modules/comments/provider/comments_provider.dart';
import 'package:ared/modules/home/provider/realestate_provider.dart';
import 'package:ared/modules/home/repositories/add_realestate_appraisal_repository.dart';
import 'package:ared/modules/lands/provider/land_provider.dart';
import 'package:ared/modules/lands/provider/lands_provider.dart';
import 'package:ared/modules/lands/repositories/land_repository.dart';
import 'package:ared/modules/layout/provider/layout_provider.dart';
import 'package:ared/modules/notifications/provider/notification_provider.dart';
import 'package:ared/modules/notifications/repositories/notification_repository.dart';
import 'package:ared/modules/offers/repositories/add_offer_repository.dart';
import 'package:ared/modules/profile/provider/profile_provider.dart';
import 'package:ared/modules/profile/repository/profile_repository.dart';
import 'package:ared/modules/splash/provider/splash_provider.dart';
import 'package:ared/modules/splash/repository/splash_repository.dart';
import 'package:ared/modules/subscription/provider/subscription_provider.dart';
import 'package:ared/modules/subscription/repositories/subscription_repository.dart';
import 'package:ared/provider/offers_provider.dart';
import 'package:ared/repositories/offers_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/local/cache_consumer.dart';
import 'core/services/network/api_consumer.dart';
import 'core/services/network/network_info.dart';
import 'modules/comments/repositories/comments_repository.dart';
import 'modules/map_specs/provider/map_specs_provider.dart';
import 'modules/offers/providers/add_offer_provider.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // External
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<PrettyDioLogger>(
    () => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));
  sl.registerLazySingleton<ApiConsumer>(() => ApiConsumer(sl<Dio>(), sl<CacheConsumer>(), sl<PrettyDioLogger>()));
  sl.registerLazySingleton<CacheConsumer>(() => CacheConsumer(sl<SharedPreferences>(), sl<FlutterSecureStorage>()));

  // Repositories
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepository(sl<ApiConsumer>(), sl<NetworkInfo>(), sl<CacheConsumer>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl<ApiConsumer>(), sl<NetworkInfo>(), sl<CacheConsumer>()),
  );
  sl.registerLazySingleton<SocialAuthRepository>(
    () => SocialAuthRepository(sl<ApiConsumer>(), sl<NetworkInfo>(), sl<CacheConsumer>()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(sl<ApiConsumer>(), sl<NetworkInfo>()),
  );
  sl.registerLazySingleton<AddOfferRepository>(() => AddOfferRepository(sl<ApiConsumer>(), sl<NetworkInfo>()));

  sl.registerLazySingleton<CommentsRepository>(() => CommentsRepository(sl<ApiConsumer>(), sl<NetworkInfo>()));
  sl.registerLazySingleton<AddRealestateAppraisalRepository>(() => AddRealestateAppraisalRepository(sl<ApiConsumer>(), sl<NetworkInfo>()));

  // Providers
  sl.registerFactory<SplashProvider>(() => SplashProvider(sl<SplashRepository>()));
  sl.registerFactory<AuthProvider>(() => AuthProvider(sl<AuthRepository>()));
  sl.registerFactory<SocialAuthAuthProvider>(() => SocialAuthAuthProvider(sl<SocialAuthRepository>()));
  sl.registerFactory<LayoutProvider>(() => LayoutProvider());
  sl.registerFactory<AddOfferProvider>(() => AddOfferProvider(sl<AddOfferRepository>()));
  sl.registerFactory<MapSpecsProvider>(() => MapSpecsProvider());
  sl.registerFactory<ProfileProvider>(() => ProfileProvider(sl<ProfileRepository>()));

  sl.registerFactory<CommentsProvider>(() => CommentsProvider(sl<CommentsRepository>()));
  sl.registerFactory<RealestateProvider>(() => RealestateProvider(sl<AddRealestateAppraisalRepository>()));

  //Notification
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepository(sl<ApiConsumer>(), sl<NetworkInfo>(), sl<CacheConsumer>()),
  );
  sl.registerFactory<NotificationProvider>(() => NotificationProvider(sl<NotificationRepository>()));

  //Subscriptions
  sl.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepository(sl<ApiConsumer>(), sl<NetworkInfo>(), sl<CacheConsumer>()),
  );
  sl.registerFactory<SubscriptionProvider>(() => SubscriptionProvider(sl<SubscriptionRepository>()));

  //Request Land
  sl.registerLazySingleton<LandRepository>(
    () => LandRepository(sl<ApiConsumer>(), sl<NetworkInfo>(), sl<CacheConsumer>()),
  );
  sl.registerFactory<LandsProvider>(() => LandsProvider(sl<LandRepository>()));
  sl.registerFactory<LandProvider>(() => LandProvider(sl<LandRepository>()));

  //Offers
  sl.registerLazySingleton<OffersRepository>(
    () => OffersRepository(sl<ApiConsumer>(), sl<NetworkInfo>()),
  );
  sl.registerFactory<OffersProvider>(() => OffersProvider(sl<OffersRepository>()));
}
