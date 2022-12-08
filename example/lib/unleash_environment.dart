import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class UnleashEnvironment {
  static Future<UnleashConfig> get config async {
    final String source = await rootBundle.loadString('lib/source.json');

    return UnleashConfig(
      proxyUrl: 'https://UNLEASH_URL/proxy',
      clientKey: 'CLIENT_KEY',
      poolMode: UnleashPollingMode.custom(const Duration(seconds: 5)),
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
      onFetched: (List<UnleashToggle> toggles) {
        debugPrint('Yay! ${toggles.length} toggles fetched.');
      },
    );
  }

  static UnleashContext get context => UnleashContext(
        properties: {
          'variant': 'ios',
        },
      );
}

class ToggleKeys {
  static String experiment = 'testing-source';
}
