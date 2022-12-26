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

  /// [getCurrentAppInstance] will return current app instance that used by
  /// unleash
  static UnleashApp? getCurrentAppInstance() => _app;

  /// [appContext] is current [UnleashContext]
  static UnleashContext? appContext;

  /// [_config] is current [UnleashConfig]
  static UnleashConfig? _config;

  /// [_client] is current [UnleashClient]
  static UnleashClient? _client;

  static Timer? _polling;

  /// Initializes a new [Unleash] instance by using [config] and [context]
  static Future<void> initializeApp({
    required UnleashConfig config,
    UnleashContext? context,
  }) async {
    /// Initialize context
    appContext = context;
    _config = config;

    Utils.logger('Initialize application');
    final cache = await UnleashCache.init();
    _client = UnleashClient(cache);

    final uri = Uri.tryParse(
      '${config.proxyUrl}?${appContext?.queryParams}',
    );

    /// Initial fetch toggles
    await _fetchToggles(uri: uri);

    /// Register polling mode
    await _registerPolling();
  }

  static Future<void> _fetchToggles({Uri? uri}) async {
    /// Use boostrap source as initial value
    final toggles = <UnleashToggle>[...?_config?.bootstrap?.source];

    /// Retrieve json data from bootstrap config
    final bootstrapJson = _config?.bootstrap?.json;

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
    final fetched = await _client?.fetch(
      uri: uri,
      headers: _config?.headers ?? {},
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
    _config?.onFetched?.call(toggles);

    Unleash._(UnleashApp._(toggles, client: _client, config: _config));
  }

  /// [_registerPolling] will call polling mode for unleash proxy
  static Future<void> _registerPolling() async {
    if (_config?.poolMode == UnleashPollingMode.none) {
      return;
    }

    final duration = _config?.poolMode ?? UnleashPollingMode.defaultInterval;

    /// Call init app periodically
    _polling = Timer.periodic(duration, (timer) async {
      final periodicUri = Uri.tryParse(
        '${_config?.proxyUrl}?${appContext?.queryParams}',
      );
      await _fetchToggles(uri: periodicUri);
      Utils.logger('Updated at ${DateTime.now()}');
      Utils.logger(periodicUri.toString());
    });
  }

  /// [dispose] will cancel all running process in unleash proxy
  static void dispose() {
    _polling?.cancel();
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
