import 'package:example/screens/basic_usage_screen.dart';
import 'package:example/screens/update_context_screen.dart';
import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';

/// Import package here
import 'package:unleash_proxy/unleash_proxy.dart';

Future<void> main() async {
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize unleash client here
  await Unleash.initializeApp(
    config: await UnleashEnvironment.config,
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BasicUsageScreen(),
                  )),
              child: const Text('Basic Usage'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateContextScreen(),
                  )),
              child: const Text('Update Context'),
            ),
          ],
        ),
      ),
    );
  }
}
