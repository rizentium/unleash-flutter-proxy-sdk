/// Unleash Config Interface
class UnleashConfig {
  /// Unleash Config constructor
  UnleashConfig({
    required this.proxyUrl,
    required this.clientKey,
    this.instanceId,
    this.poolMode = const Duration(seconds: 15),
  });

  /// Unleash Proxy URL
  final String proxyUrl;

  /// Unleash Client Key
  final String clientKey;

  /// Unleash Instance Id
  final String? instanceId;

  /// Unleash Polling Mode
  final Duration poolMode;

  /// Header default for Unleash Request
  Map<String, String> get headers => {
        'Authorization': clientKey,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
}
