part of unleash_proxy;

/// [UnleashApp] is application instance for unleash
class UnleashApp {
  UnleashApp._() {
    UnleashAppPlatform.verify(_delegate);
  }

  @visibleForTesting
  // ignore: public_member_api_docs
  static UnleashAppPlatform? delegatePackingProperty;

  static UnleashAppPlatform get _delegate {
    return delegatePackingProperty ??= UnleashAppPlatform.instance;
  }

  /// [options] is Unleash Configuration
  UnleashOptions? get options => _delegate.options;

  /// [toggles] is List of UnleashToggle for unleash application instance
  List<UnleashToggle>? get toggles => _delegate.toggles;

  /// [context] will return current unleash context
  UnleashContext? get context => _delegate.context;

  /// [context] will set or update current unleash context
  Future<void> setContext(
    UnleashContext? context, {
    bool? forceUpdate = true,
  }) async {
    _delegate.context = context;
    if (forceUpdate ?? false) await immediateUpdate();
  }

  /// [initialize] will initialize unleash application
  static Future<UnleashApp> initialize({
    required UnleashOptions options,
    required http.Client client,
    UnleashContext? context,
  }) async {
    _delegate.options = options;
    _delegate.context = context;
    await _delegate.fetch(client: client);

    return UnleashApp._();
  }

  /// [dispose] will cancel polling timer
  void dispose() {
    _delegate.pollingTimer?.cancel();
  }

  /// [immediateUpdate] will force update current toggles
  Future<void> immediateUpdate({http.Client? client}) async {
    await _delegate.immediateUpdate(client: client);
  }

  /// [isEnabled] return current selected toggle or return false if not exist.
  /// This method can be override also by set [overrideValue] or throw to defaut
  /// value by set [defaultValue].
  bool isEnabled(String key, {bool? defaultValue, bool? overrideValue}) {
    return _delegate.isEnabled(
      key,
      defaultValue: defaultValue,
      overrideValue: overrideValue,
    );
  }

  /// [getToggle] return current fetched toggles
  UnleashToggle? getToggle(String key) => _delegate.getToggle(key);
}
