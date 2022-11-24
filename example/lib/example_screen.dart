import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
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
