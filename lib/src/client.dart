import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unleash_flutter_proxy_sdk/src/data/response.dart';
import 'package:unleash_flutter_proxy_sdk/src/data/toggle.dart';
import 'package:unleash_flutter_proxy_sdk/src/utils.dart';

/// This class will handle all of the fetch feature from endpoint
class UnleashClient {
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
      final toggles = ToggleResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      Utils.logger('Fetched ${toggles.toggles.length} toggles');
      return toggles.toggles;
    } catch (e) {
      Utils.logger('Error', error: e);
      return null;
    }
  }
}
