import 'package:http/http.dart' as http;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:unleash_proxy/src/unleash/unleash_method_channel.dart';
import 'package:unleash_proxy/src/unleash_app/unleash_app_platform_interface.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

abstract class UnleashPlatform extends PlatformInterface {
  /// Constructs a UnleashProxyPlatform.
  UnleashPlatform() : super(token: _token);

  static final Object _token = Object();

  static void verify(UnleashAppPlatform instance) {
    PlatformInterface.verify(instance, _token);
  }

  static UnleashPlatform _instance = MethodChannelUnleash();

  /// The default instance of [UnleashPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnleash].
  static UnleashPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UnleashPlatform] when
  /// they register themselves.
  static set instance(UnleashPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  UnleashAppPlatform get app {
    throw UnimplementedError('app has not been implemented.');
  }

  UnleashContext? context;

  Future<UnleashApp> initializeApp({
    required UnleashOptions options,
    required http.Client client,
    UnleashContext? appContext,
  }) async {
    throw UnimplementedError('initializeApp() has not been implemented.');
  }
}
