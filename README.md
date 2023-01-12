# Unleash Flutter Proxy SDK

[![pub package][pub_badge]][pub_badge]
[![pub points][pub_points]][pub_points]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

This library is meant to be used with the [unleash-proxy][unleash_proxy_link]. The proxy application layer will sit between your unleash instance and your client applications, and provides performance and security benefits. DO NOT TRY to connect this library directly to the unleash instance, as the datasets follow different formats because the proxy only returns evaluated toggle information.

## Installation 💻

**❗ In order to start using Unleash you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Add `unleash_proxy` to your `pubspec.yaml`:

```yaml
dependencies:
  unleash_proxy:
```

Install it:

```sh
flutter packages get
```

---

## Usage

### Initialize Unleash Proxy

Unleash context and configuration is required for initialize unleash app.

#### Context

The important properties to configure on the context are:
- appName - In case you use strategies that depend on which app
- userId - GradualRolloutStrategies often use this to decide stickiness when assigning which group of users the user end up in
- sessionId - GradualRolloutStrategies often use this to decide stickiness
- properties - In case you use custom strategies

Example:

```dart
UnleashContext(
  appName: 'APP_NAME',
  userId: 'USER_ID',
  sessionId: 'SESSION_ID',
  properties: {'variant': 'ios'},
);
```

Update current context:

```dart
class UnleashScreen extends StatelessWidget {
  UnleashScreen({required this.unleash});
  final UnleashApp unleash;
  
  /// [updateContext] method will update current context
  Future<void> updateContext() async {
    await unleashApp.setContext(UnleashContext(
      properties: {'variant': 'ios'},
      userId: 'exampleId',
    ));
  }
}

```

#### Configuration

For the config you must set two variables, and if you'd like to be notified when the polling thread has found updates you should also configure pollMode:
- proxyUrl - Where your proxy installation is located, for Unleash-Hosted's demo instance this is at https://app.unleash-hosted.com/demo/proxy but yours will be somewhere else
- clientKey - The api key for accessing your proxy. (renamed from clientSecret in v0.4.0)
- pollMode - See PollingModes
- bootstrap - Allows you to bootstrap the cached feature toggle configuration by using `json` format or `List<UnleashToggle>`
- onFetched - Run a function every toggle fetched from server

Example:

```dart
UnleashOptions(
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
)
```

#### PollingModes

For updating toggles based on server, you have to set pollingMode in unleash configuration. Polling Mode will set to 15 seconds by default, but you can set to `const Duration(seconds: 0)` if you don't want to use toggle interval update or you can custom the interval duration by using custom polling mode.

If you want to stop polling imediatelly, you can call `dispose()`. Unleash will use the latest cache from your cache storage.

#### Initialize

To use the `unleash_proxy` to Flutter application, initialize `unleash_proxy` first. Create `unleash_environment.dart` file to save environment variables. You can follow the code bellow for basic environment config:

```dart
import 'package:flutter/services.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class UnleashEnvironment {
  static UnleashOptions get config => UnleashOptions(
    proxyUrl: 'https://UNLEASH_URL/proxy',
    clientKey: 'CLIENT_KEY',
  );

  static UnleashContext get context => UnleashContext();
}

class ToggleKeys {
  static String experiment = 'toggle-experiment';
}

```

Initialize `unleash_proxy` to the main file:

```dart

import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';

/// Import package here
import 'package:unleash_proxy/unleash_proxy.dart';

Future<void> main() async {
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize unleash client here
  final unleashApp = await Unleash.initializeApp(
    options: await UnleashEnvironment.config,
    context: UnleashEnvironment.context,
  );

  runApp(App(app: unleashApp));
}

```

### Use Unleash Proxy Toggle

```dart
import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class BasicUsageScreen extends StatelessWidget {
  const BasicUsageScreen({super.key, required this.app});

  final UnleashApp app;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Usage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Toggle Status',
              style: TextStyle(height: 2.5, fontWeight: FontWeight.w500),
            ),
            toggleStatus(),
          ],
        ),
      ),
    );
  }

  Widget toggleStatus() {
    /// Call [isEnabled] to get the toggle value
    final status = app.isEnabled(ToggleKeys.experiment);

    return Text(status == true ? 'Enabled' : 'Disabled');
  }
}
```

Can check the example [here][unleash_example]

## Continuous Integration 🤖

Unleash Flutter Proxy SDK comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---

## Running Tests 🧪

For first time users, install the [very_good_cli][very_good_cli_link]:

```sh
dart pub global activate very_good_cli
```

To run all unit tests:

```sh
very_good test --coverage
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

## Issues

Please file any issues, bugs or feature requests as an issue on the [GitHub][issues_link] page. Commercial support is available, you can contact me at [rizentium@gmail.com][email].

## Author

This `unleash_proxy` plugin for Flutter is developed by [Arif Hidayat][github_profile].

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
[unleash_proxy_link]: https://github.com/Unleash/unleash-proxy
[unleash_example]: https://github.com/rizentium/unleash-flutter-proxy-sdk/blob/main/example/lib/main.dart
[github_profile]: https://github.com/rizentium
[email]: mailto:rizentium@gmail.com
[issues_link]: https://github.com/rizentium/unleash-flutter-proxy-sdk/issues
[pub_badge]: https://img.shields.io/pub/v/unleash_proxy.svg
[pub_points]: https://img.shields.io/pub/points/unleash_proxy?color=2E8B57&label=pub%20points
[polling_mode]: https://github.com/rizentium/unleash-flutter-proxy-sdk#PollingModes