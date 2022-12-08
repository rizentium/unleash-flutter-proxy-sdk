/// Unleash Polling Mode
class UnleashPollingMode {
  /// Polling is disabled
  static Duration none = Duration.zero;

  /// Default polling interval duration
  static Duration defaultInterval = const Duration(seconds: 15);

  /// Custom polling interval
  static Duration custom(Duration duration) => duration;
}
