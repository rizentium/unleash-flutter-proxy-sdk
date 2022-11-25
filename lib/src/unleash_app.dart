part of unleash_proxy;

/// Represents a single Unleash app instance.
///
/// You can get an instance by calling [Unleash.app()].
class UnleashApp extends UnleashAppPlatform {
  UnleashApp._(this._toggles, {required super.config, required super.client});

  final List<UnleashToggle>? _toggles;

  /// contains all the features from unleash
  List<UnleashToggle>? get toggles => _toggles;

  @override
  UnleashToggle? getToggle(String key) {
    return _toggles?.firstWhereOrNull((e) => e.name == key);
  }

  @override
  bool isEnabled(
    String key, {
    bool? defaultValue,
    bool? overrideValue,
  }) {
    if (overrideValue == null) {
      return getToggle(key)?.enabled ?? defaultValue ?? false;
    } else {
      return overrideValue;
    }
  }
}
