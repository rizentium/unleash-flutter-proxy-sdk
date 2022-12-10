import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unleash_proxy/src/cache/cache.dart';
import 'package:unleash_proxy/src/data/response.dart';
import 'package:unleash_proxy/src/data/toggle.dart';
import 'package:unleash_proxy/src/utils.dart';

/// This class will handle all of the fetch feature from endpoint
class UnleashClient {
  /// [UnleashClient] constructor
  UnleashClient(this._cache);

  final UnleashCache _cache;

  /// Fetch all features from server
  Future<List<UnleashToggle>?> fetch({
    Uri? uri,
    required Map<String, String> headers,
  }) async {
    Utils.logger('Fetching toggles from server');
    try {
      if (uri == null) {
        throw Exception('URI is empty, need to set URI first');
      }
      final response = await http.get(uri, headers: headers);
      final body = response.body;

      final toggles = _stringToToggles(body);

      await _cacheResponse(
        value: body,
        length: toggles.toggles.length,
      );

      Utils.logger('Fetched ${toggles.toggles.length} toggles');
      return toggles.toggles;
    } catch (e) {
      final cache = _cache.getToggles();

      if (cache == null) {
        Utils.logger('Error', error: e);
        return null;
      }

      final toggles = _stringToToggles(cache);

      Utils.logger(
        'Fetched ${toggles.toggles.length} toggles from cache storage',
        error: e,
      );

      return toggles.toggles;
    }
  }

  Future<void> _cacheResponse({
    required String value,
    required int length,
  }) async {
    final isCached = await _cache.setToggles(value);

    if (isCached) {
      Utils.logger('$length toggles cached successfully');
    } else {
      Utils.logger('$length toggles cached unsuccessfully');
    }
  }

  ToggleResponse _stringToToggles(String value) => ToggleResponse.fromJson(
        json.decode(value) as Map<String, dynamic>,
      );
}
