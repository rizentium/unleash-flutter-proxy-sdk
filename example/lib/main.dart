import 'package:example/first_screen.dart';
import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';

/// Import package here
import 'package:unleash_flutter_proxy_sdk/unleash.dart';

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
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondScreen(),
                  )),
              child: const Text('First Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
