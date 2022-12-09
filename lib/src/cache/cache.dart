import 'package:shared_preferences/shared_preferences.dart';
import 'package:unleash_proxy/src/cache/cache_platform.dart';

/// [UnleashCache]
class UnleashCache extends UnleashCachePlatform {
  UnleashCache._(this._impl);

  final _key = '__unleash_toggles';

  final SharedPreferences _impl;

  /// Initialize unleash cache by calling [init]
  static Future<UnleashCache> init() async {
    return UnleashCache._(await SharedPreferences.getInstance());
  }

  @override
  String? getToggles() => _impl.getString(_key);

  @override
  Future<bool> setToggles(String value) => _impl.setString(_key, value);

  @override
  Future<bool> clear() => _impl.remove(_key);
}
