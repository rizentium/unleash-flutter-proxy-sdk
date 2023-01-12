import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:unleash_proxy/src/data/response.dart';
import 'package:unleash_proxy/src/data/toggle.dart';
import 'package:unleash_proxy/src/unleash_app/unleash_app_platform_interface.dart';

/// An implementation of [MethodChannelUnleashApp] that uses method channels.
class MethodChannelUnleashApp extends UnleashAppPlatform {
  MethodChannelUnleashApp();

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('unleash_proxy');

  @override
  UnleashToggle? getToggle(String key) {
    try {
      return toggles?.firstWhere((e) => e.name == key);
    } catch (e) {
      return null;
    }
  }

  @override
  bool isEnabled(String key, {bool? defaultValue, bool? overrideValue}) {
    return getToggle(key)?.enabled ?? false;
  }

  @override
  String get queryParams {
    return context != null ? '?${context?.queryParams}' : '';
  }

  @override
  Future<void> fetch({
    required http.Client client,
  }) async {
    try {
      Future<List<UnleashToggle>> request() async {
        var serielized = <UnleashToggle>[];
        final uri = Uri.tryParse('${options?.proxyUrl}$queryParams');

        if (uri != null) {
          final response = await client.get(uri, headers: options?.headers);
          final body = response.body;
          serielized = ToggleResponse.fromJson(
            json.decode(body) as Map<String, dynamic>,
          ).toggles;
        }

        return serielized;
      }

      final duration = options?.poolMode ?? const Duration(seconds: 15);

      toggles = await request();

      if (duration.inSeconds > 0) {
        pollingTimer = Timer.periodic(duration, (timer) async {
          toggles = await request();
        });
      }
    } catch (e) {
      log('Error on fetching data', error: e);
    }
  }
}
