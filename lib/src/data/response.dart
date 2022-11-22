import 'package:unleash_proxy/src/data/toggle.dart';

/// Feature Response
class ToggleResponse {
  /// Feature Response constructor
  ToggleResponse({required this.toggles});

  /// Convert data from JSON
  ToggleResponse.fromJson(Map<String, dynamic> json)
      : toggles = List<UnleashToggle>.from(
          (json['toggles'] as List)
              .cast<Map<String, dynamic>>()
              .map(UnleashToggle.fromJson),
        );

  /// List of [UnleashToggle]
  final List<UnleashToggle> toggles;
}
