import 'package:flutter/material.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

class ToggleListScreen extends StatelessWidget {
  const ToggleListScreen({super.key, required this.app});

  final UnleashApp app;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggle list screen'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => _toggleTile(
          index: index,
        ),
        itemCount: app.toggles?.length ?? 0,
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _toggleTile({required int index}) {
    final toggle = app.toggles?[index];
    if (toggle == null) {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
    return ListTile(
      title: Text(toggle.name),
      subtitle: Text(toggle.enabled == true ? 'Enabled' : 'Disabled'),
    );
  }
}
