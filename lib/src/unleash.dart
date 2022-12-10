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

  /// [_app] is current unleash app instance
  static UnleashApp? _app;

  /// [appContext] is current [UnleashContext]
  static UnleashContext? appContext;

  /// Initializes a new [Unleash] instance by using [config] and [context]
  static Future<void> initializeApp({
    required UnleashConfig config,
    UnleashContext? context,
  }) async {
    /// Initialize context
    appContext = context;

    Utils.logger('Initialize application');
    final cache = await UnleashCache.init();
    final client = UnleashClient(cache);

    final uri = Uri.tryParse(
      '${config.proxyUrl}?${appContext?.queryParams}',
    );

    /// Initial fetch toggles
    await _fetchToggles(config: config, client: client, uri: uri);

    if (config.poolMode == UnleashPollingMode.none) {
      return;
    }

    /// Call init app periodically
    Timer.periodic(config.poolMode, (timer) async {
      final periodicUri = Uri.tryParse(
        '${config.proxyUrl}?${appContext?.queryParams}',
      );
      await _fetchToggles(config: config, client: client, uri: periodicUri);
      Utils.logger('Updated at ${DateTime.now()}');
      Utils.logger(periodicUri.toString());
    });
  }

  static Future<void> _fetchToggles({
    required UnleashConfig config,
    Uri? uri,
    required UnleashClient client,
  }) async {
    /// Use boostrap source as initial value
    final toggles = <UnleashToggle>[...?config.bootstrap?.source];

    /// Retrieve json data from bootstrap config
    final bootstrapJson = config.bootstrap?.json;

    if (bootstrapJson != null) {
      final bootstrapToggles = ToggleResponse.fromJson(
        json.decode(bootstrapJson) as Map<String, dynamic>,
      );

      for (final e in bootstrapToggles.toggles) {
        final index = toggles.indexWhere((f) => f.name == e.name);

        if (index == -1) {
          toggles.add(e);
        } else {
          toggles[index] = e;
        }
      }
    }

    /// Fetch data from server
    final fetched = await client.fetch(
      uri: uri,
      headers: config.headers,
    );

    fetched?.forEach((e) {
      final index = toggles.indexWhere((f) => f.name == e.name);

      if (index == -1) {
        toggles.add(e);
      } else {
        toggles[index] = e;
      }
    });

    /// Run onFetched function if exist
    config.onFetched?.call(toggles);

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
  static bool isEnabled(String key, {bool? defaultValue, bool? overrideValue}) {
    if (overrideValue != null) {
      return overrideValue;
    }
    return _app?.isEnabled(key) ?? defaultValue ?? false;
  }
}
