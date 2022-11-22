part of unleash_flutter_proxy_sdk;

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
  bool isEnabled(String key, {bool? defaultValue}) {
    return getToggle(key)?.enabled ?? defaultValue ?? false;
  }
}
