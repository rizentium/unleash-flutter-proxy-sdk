part of unleash_proxy;

/// [Unleash]
class Unleash {
  Unleash._();

  // Cached & lazily loaded instance of [UnleashPlatform].
  // Avoids a [MethodChannelUnleash] being initialized until the user
  // starts using Unleash.
  // The property is visible for testing to allow tests to set a mock
  // instance directly as a static property since the class is not initialized.
  @visibleForTesting
  // ignore: public_member_api_docs
  static UnleashPlatform? delegatePackingProperty;

  static UnleashPlatform get _delegate {
    return delegatePackingProperty ??= UnleashPlatform.instance;
  }

  /// [app] return current unleash application
  static UnleashAppPlatform get app {
    return _delegate.app;
  }

  /// [initializeApp] return [UnleashApp] instance
  static Future<UnleashApp> initializeApp({
    required UnleashOptions options,
    http.Client? client,
    UnleashContext? context,
  }) {
    return _delegate.initializeApp(
      options: options,
      client: client ?? http.Client(),
      appContext: context,
    );
  }
}
