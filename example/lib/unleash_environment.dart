import 'package:unleash_flutter_proxy_sdk/unleash.dart';

class UnleashEnvironment {
  static UnleashConfig get config => UnleashConfig(
        proxyUrl: 'https://UNLEASH_URL/proxy',
        clientKey: 'CLIENT_KEY',
      );

  static UnleashContext get context => UnleashContext();
}

class ToggleKeys {
  static String experiment = 'unleash-toggle-name';
}
