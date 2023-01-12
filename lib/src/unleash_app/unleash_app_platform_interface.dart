import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:unleash_proxy/src/unleash_app/unleash_app_method_channel.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

abstract class UnleashAppPlatform extends PlatformInterface {
  UnleashAppPlatform() : super(token: _token);

  static final Object _token = Object();

  static void verify(UnleashAppPlatform instance) {
    PlatformInterface.verify(instance, _token);
  }

  /// The default instance of [UnleashAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnleashApp].
  static UnleashAppPlatform _instance = MethodChannelUnleashApp();

  /// The default instance of [UnleashPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnleash].
  static UnleashAppPlatform get instance => _instance;

  static set instance(UnleashAppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  UnleashOptions? options;

  UnleashContext? context;

  String get queryParams {
    throw UnimplementedError();
  }

  /// [toggles] return list of fetched toggles
  List<UnleashToggle>? toggles;

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

  Future<void> fetch({
    required http.Client client,
  }) {
    throw UnimplementedError();
  }
}
