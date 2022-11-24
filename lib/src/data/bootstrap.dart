import 'package:unleash_proxy/src/data/toggle.dart';

/// Unleash Bootstrap
class UnleashBootstrap {
  /// Unleash Bootstrap constructor
  UnleashBootstrap({this.source, this.json});

  /// List of [UnleashToggle] for unleash bootstrap
  final List<UnleashToggle>? source;

  /// Raw json input for unleash input
  /// This variable is unused for new
  final String? json;
}
