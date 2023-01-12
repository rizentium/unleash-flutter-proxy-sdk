import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unleash_proxy/src/unleash/unleash_platform_interface.dart';
import 'package:unleash_proxy/src/unleash_app/unleash_app_platform_interface.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

/// An implementation of [UnleashPlatform] that uses method channels.
class MethodChannelUnleash extends UnleashPlatform {
  @visibleForTesting
  UnleashAppPlatform? appDelegatePackingProperty;

  @override
  UnleashAppPlatform get app {
    return appDelegatePackingProperty ??= UnleashAppPlatform.instance;
  }

  @override
  Future<UnleashApp> initializeApp({
    required UnleashOptions options,
    required http.Client client,
    UnleashContext? appContext,
  }) {
    return UnleashApp.initialize(
      options: options,
      client: client,
      context: appContext,
    );
  }
}
