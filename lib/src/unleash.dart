// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

part of unleash_proxy;

/// {@template unleash}
/// Unleash Flutter Proxy SDK Client
/// {@endtemplate}
class Unleash extends UnleashPlatform {
  /// {@macro unleash}
  Unleash._(UnleashApp unleashApp) {
    _app = unleashApp;
  }

  ///
  static UnleashApp? _app;

  /// Initializes a new [Unleash] instance by using [config] and [context]
  static Future<void> initializeApp({
    required UnleashConfig config,
    UnleashContext? context,
  }) async {
    Utils.logger('Initialize application');
    final client = UnleashClient();

    final uri = Uri.tryParse('${config.proxyUrl}?${context?.queryParams}');

    /// Initial call
    await _initApp(config: config, client: client, uri: uri);

    if (config.poolMode == UnleashPollingMode.none) {
      return;
    }

    Timer.periodic(config.poolMode, (timer) async {
      await _initApp(config: config, client: client, uri: uri);
      Utils.logger('Updated at ${DateTime.now()}');
    });
  }

  static Future<void> _initApp({
    required UnleashConfig config,
    Uri? uri,
    required UnleashClient client,
  }) async {
    final toggles = await client.fetch(
      uri: uri,
      headers: config.headers,
    );
    Unleash._(UnleashApp._(toggles, client: client, config: config));
  }

  /// Get a single feature by using toggle [key] and return [UnleashToggle] or
  /// null if data is not available
  static UnleashToggle? getToggle(String key) => _app?.getToggle(key);

  /// Get all toggles and return list of [UnleashToggle]  or null if data is
  /// not available
  static List<UnleashToggle>? getToggles() => _app?.toggles;

  /// Get toggle status by toggle [key] and return boolean status
  /// You can pass the default value also. So, if toggle is not available
  /// from unleash sources, it will throw to [defaultValue]
  static bool isEnabled(String key, {bool? defaultValue}) {
    return _app?.isEnabled(key) ?? defaultValue ?? false;
  }
}
