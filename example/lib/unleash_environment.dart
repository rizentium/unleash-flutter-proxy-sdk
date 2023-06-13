import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class UnleashEnvironment {
  static Future<UnleashOptions> get config async {
    final String source = await rootBundle.loadString('lib/source.json');

    return UnleashOptions(
        proxyUrl: 'https://app.unleash-hosted.com/demo/api/proxy',
        clientKey: 'proxy-123',
        poolMode: const Duration(seconds: 5),
        bootstrap: UnleashBootstrap(
          source: [
            UnleashToggle(
              enabled: true,
              name: 'testing-source',
              variant: UnleashToggleVariant(name: 'disabled', enabled: false),
            ),
          ],
          json: source,
        ),
        onFetchedSuccess: (List<UnleashToggle> toggles) {
          debugPrint('Yay! ${toggles.length} toggles fetched.');
        },
        onFetchedFailed: (Exception e) {
          debugPrint('Ouch! failed to fetch toggles with error: $e.');
        });
  }

  static UnleashContext get context => UnleashContext(
        properties: {'variant': 'ios'},
      );
}

class ToggleKeys {
  static String experiment = 'unleash-experiment';
}
