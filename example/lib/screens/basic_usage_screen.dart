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
