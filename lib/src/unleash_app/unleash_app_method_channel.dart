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
  /// [MethodChannelUnleashApp]
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
      final duration = options?.poolMode ?? const Duration(seconds: 15);

      Future<List<UnleashToggle>?> request() async {
        final fetchedFromServer = await _fetchFromServer(client: client) ?? [];

        _fetchFromBootstrap()?.forEach((e) {
          final index = fetchedFromServer.indexWhere((f) => e.name == f.name);
          if (index == -1) fetchedFromServer.add(e);
        });

        return fetchedFromServer;
      }

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

  Future<List<UnleashToggle>?> _fetchFromServer({
    required http.Client client,
  }) async {
    try {
      var result = <UnleashToggle>[];
      final uri = Uri.tryParse('${options?.proxyUrl}$queryParams');

      if (uri != null) {
        final response = await client.get(uri, headers: options?.headers);
        final body = response.body;
        result = ToggleResponse.fromJson(
          json.decode(body) as Map<String, dynamic>,
        ).toggles;
      }

      return result;
    } catch (e) {
      return null;
    }
  }

  List<UnleashToggle>? _fetchFromBootstrap() {
    final response = options?.bootstrap?.source ?? [];
    final bootstrapJson = options?.bootstrap?.json;

    if (bootstrapJson != null) {
      final jsonSerialized = ToggleResponse.fromJson(
        json.decode(bootstrapJson) as Map<String, dynamic>,
      ).toggles;
      for (final e in jsonSerialized) {
        final index = response.indexWhere((i) => e.name == i.name);
        if (index != -1) response.add(e);
      }
    }

    return response;
  }
}
