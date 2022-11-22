// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:collection/collection.dart';
import 'package:unleash_flutter_proxy_sdk/src/client.dart';
import 'package:unleash_flutter_proxy_sdk/src/config.dart';
import 'package:unleash_flutter_proxy_sdk/src/context.dart';
import 'package:unleash_flutter_proxy_sdk/src/data/toggle.dart';
import 'package:unleash_flutter_proxy_sdk/src/platform.dart';
import 'package:unleash_flutter_proxy_sdk/src/utils.dart';

/// {@template unleash}
/// Unleash Flutter Proxy SDK Client
/// {@endtemplate}
class Unleash extends Platform {
  /// {@macro unleash}
  Unleash._(this._toggles);

  final List<UnleashToggle>? _toggles;

  /// contains all the features from unleash
  List<UnleashToggle>? get toggles => _toggles;

  /// Initializes a new [Unleash] instance by [config] and returns
  /// the created app.
  static Future<Unleash> initializeApp({
    required UnleashConfig config,
    UnleashContext? context,
  }) async {
    Utils.logger('Initialize application');
    final client = UnleashClient();

    final uri = Uri.tryParse('${config.proxyUrl}?${context?.queryParams}');

    final toggles = await client.fetch(
      uri: uri,
      headers: config.headers,
    );
    Utils.logger('Initialized');
    return Unleash._(toggles);
  }

  @override
  UnleashToggle? getFeature(String key) {
    return _toggles?.firstWhereOrNull((e) => e.name == key);
  }

  @override
  bool isEnabled(String key, {bool? defaultValue}) {
    return getFeature(key)?.enabled ?? defaultValue ?? false;
  }
}
