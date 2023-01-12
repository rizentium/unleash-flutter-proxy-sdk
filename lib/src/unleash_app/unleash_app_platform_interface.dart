import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:unleash_proxy/src/unleash_app/unleash_app_method_channel.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

/// [UnleashAppPlatform]
abstract class UnleashAppPlatform extends PlatformInterface {
  /// [UnleashAppPlatform]
  UnleashAppPlatform() : super(token: _token);

  static final Object _token = Object();

  /// [verify]
  static void verify(UnleashAppPlatform instance) {
    PlatformInterface.verify(instance, _token);
  }

  /// The default instance of [UnleashAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnleashApp].
  static UnleashAppPlatform _instance = MethodChannelUnleashApp();

  /// The default instance of [UnleashAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnleashApp].
  static UnleashAppPlatform get instance => _instance;

  static set instance(UnleashAppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// [options]
  UnleashOptions? options;

  /// [context]
  UnleashContext? context;

  /// [toggles] return list of fetched toggles
  List<UnleashToggle>? toggles;

  /// [pollingTimer]
  Timer? pollingTimer;

  /// Get a single feature by using toggle [key] and return [UnleashToggle]
  UnleashToggle? getToggle(String key) {
    throw UnimplementedError();
  }

  /// Get toggle status by toggle [key] and return boolean status
  /// You can pass the default value also. So, if toggle is not available
  /// from unleash sources, it will throw to [defaultValue]
  bool isEnabled(
    String key, {
    bool? defaultValue,
    bool? overrideValue,
  }) {
    throw UnimplementedError();
  }

  /// [queryParams]
  String get queryParams {
    throw UnimplementedError();
  }

  /// [fetch]
  Future<void> fetch({
    required http.Client client,
  }) {
    throw UnimplementedError();
  }
}
