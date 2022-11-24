import 'package:flutter/services.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class UnleashEnvironment {
  static Future<UnleashConfig> get config async {
    final String source = await rootBundle.loadString('lib/source.json');

    return UnleashConfig(
      proxyUrl: 'https://UNLEASH_URL/proxy',
      clientKey: 'CLIENT_KEY',
      poolMode: UnleashPollingMode.none,
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
