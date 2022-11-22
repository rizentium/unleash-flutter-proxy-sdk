/// Unleash feature data interface
class UnleashToggle {
  /// Unleash Feature constructor
  UnleashToggle({
    required this.enabled,
    required this.name,
    required this.impressionData,
  });

  /// Convert from dynamic map to [UnleashToggle] format
  UnleashToggle.fromJson(Map<String, dynamic> json)
      : enabled = json['enabled'] as bool,
        name = json['name'] as String,
        impressionData = json['impressionData'] as bool;

  /// Toggle Status
  final bool enabled;

  /// Toggle Name
  final String name;

  /// Toggle Impression Data
  final bool impressionData;

  /// Convert from [UnleashToggle] to dynamic format
  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'name': name,
        'impressionData': impressionData,
      };
}
