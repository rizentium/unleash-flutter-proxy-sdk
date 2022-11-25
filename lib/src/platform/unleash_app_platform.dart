import 'package:unleash_proxy/unleash_proxy.dart';

/// Abstract class for Unleash Platform
abstract class UnleashAppPlatform {
  /// Unleash Platform constructor
  UnleashAppPlatform({required this.config, required this.client});

  /// Unleash Config
  final UnleashConfig config;

  /// Unleash Client
  final UnleashClient client;

  /// Get a single feature by using toggle [key] and return [UnleashToggle]
  UnleashToggle? getToggle(String key);

  /// Get toggle status by toggle [key] and return boolean status
  /// You can pass the default value also. So, if toggle is not available
  /// from unleash sources, it will throw to [defaultValue]
  bool isEnabled(
    String key, {
    bool? defaultValue,
    bool? overrideValue,
  });
}
