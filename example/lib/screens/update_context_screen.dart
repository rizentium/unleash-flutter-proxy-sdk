import 'dart:async';

import 'package:example/unleash_environment.dart';
import 'package:flutter/material.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class UpdateContextScreen extends StatefulWidget {
  const UpdateContextScreen({super.key});

  @override
  State<UpdateContextScreen> createState() => _UpdateContextScreenState();
}

class _UpdateContextScreenState extends State<UpdateContextScreen> {
  bool toggleStatus = false;
  bool isLoading = false;

  @override
  void initState() {
    fetchToggleStatus();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchToggleStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Context'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Toggle Status',
              style: TextStyle(height: 2.5, fontWeight: FontWeight.w500),
            ),
            experimentToggle,
            const SizedBox(height: 12.0),
            isLoading
                ? const SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 4.0),
                  )
                : OutlinedButton(
                    onPressed: () => updateContext(),
                    child: const Text('Update Context'),
                  ),
          ],
        ),
      ),
    );
  }

  void updateContext() {
    setState(() {
      /// Set status to loading
      isLoading = true;
    });

    /// Update current unleash context
    Unleash.appContext = UnleashContext(
      userId: 'exampleId',
    );
  }

  void fetchToggleStatus() {
    /// Call [isEnabled] to get the toggle value
    setState(() {
      toggleStatus = Unleash.isEnabled(ToggleKeys.experiment);
      isLoading = false;
    });
  }

  Widget get experimentToggle => Text(
        toggleStatus == true ? 'Enabled' : 'Disabled',
      );
}
