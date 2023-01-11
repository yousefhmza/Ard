import 'package:ared/core/services/local/cache_consumer.dart';
import 'package:ared/core/services/network/api_consumer.dart';
import 'package:ared/core/services/network/network_info.dart';

class SocialAuthRepository {
  final NetworkInfo _networkInfo;
  final ApiConsumer _apiConsumer;
  final CacheConsumer _cacheConsumer;

  SocialAuthRepository(this._apiConsumer, this._networkInfo, this._cacheConsumer);
}
