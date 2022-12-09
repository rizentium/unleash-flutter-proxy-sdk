/// [UnleashCachePlatform]
abstract class UnleashCachePlatform {
  /// [getToggles] is json string of toggles
  String? getToggles();

  /// [setToggles] function will save [String] payload to [UnleashCachePlatform]
  Future<bool> setToggles(String value);

  /// [clear] function will clear all current data
  Future<bool> clear();
}
