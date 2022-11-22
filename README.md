# Unleash Flutter Proxy SDK

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

To use the `unleash_proxy` to your Flutter application read the code example below:

```dart

import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';

/// Import package here
import 'package:unleash_proxy/unleash_proxy.dart';

Future<void> main() async {
  /// Initialize unleash client here
  await Unleash.initializeApp(
    config: UnleashEnvironment.config,
    context: UnleashEnvironment.context,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unleash Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const UnleashPage(),
    );
  }
}

class UnleashPage extends StatefulWidget {
  const UnleashPage({super.key});

  @override
  State<UnleashPage> createState() => _UnleashPageState();
}

class _UnleashPageState extends State<UnleashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unleash Page'),
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
    final status = Unleash.isEnabled(ToggleKeys.experiment);

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