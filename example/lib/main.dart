import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';

/// Import package here
import 'package:unleash_flutter_proxy_sdk/unleash.dart';

Future<void> main() async {
  /// Initialize unleash client here
  final unleash = await Unleash.initializeApp(
    config: UnleashEnvironment.config,
    context: UnleashEnvironment.context,
  );

  runApp(App(unleash: unleash));
}

class App extends StatelessWidget {
  const App({super.key, required this.unleash});

  final Unleash unleash;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unleash Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UnleashPage(unleash: unleash),
    );
  }
}

class UnleashPage extends StatefulWidget {
  const UnleashPage({super.key, required this.unleash});

  final Unleash unleash;

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
    final status = widget.unleash.isEnabled(ToggleKeys.experiment);

    return Text(status ? 'Enabled' : 'Disabled');
  }
}
