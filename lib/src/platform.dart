import 'package:unleash_flutter_proxy_sdk/src/data/toggle.dart';

/// Abstract class for Unleash Platform
abstract class Platform {
  /// Get a single feature by using toggle [key] and return [UnleashToggle]
  UnleashToggle? getFeature(String key);

  /// Get toggle status by toggle [key] and return boolean status
  /// You can pass the default value also. So, if toggle is not available
  /// from unleash sources, it will throw to [defaultValue]
  bool isEnabled(String key, {bool? defaultValue});
}
