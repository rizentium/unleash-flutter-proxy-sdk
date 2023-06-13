import 'package:unleash_proxy/unleash_proxy.dart';

/// Unleash Config Interface
class UnleashOptions {
  /// Unleash Config constructor
  UnleashOptions({
    required this.proxyUrl,
    required this.clientKey,
    this.instanceId,
    this.poolMode = const Duration(seconds: 15),
    this.bootstrap,
    this.onFetchedSuccess,
    this.onFetchedFailed,
  });

  /// Unleash Proxy URL
  final String proxyUrl;

  /// Unleash Client Key
  final String clientKey;

  /// [instanceId] is not supported yet.
  final String? instanceId;

  /// Unleash Polling Mode
  final Duration poolMode;

  /// [bootstrap] is not supported yet.
  final UnleashBootstrap? bootstrap;

  /// Header default for Unleash Request
  Map<String, String> get headers => {
        'Authorization': clientKey,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  /// Run this function every successful fetch from server
  final void Function(List<UnleashToggle> toggles)? onFetchedSuccess;

  /// Run this function every failed fetch from server
  final void Function(Exception e)? onFetchedFailed;
}
