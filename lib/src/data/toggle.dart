/// Unleash feature data interface
class UnleashToggle {
  /// Unleash Toggle constructor
  UnleashToggle({
    required this.enabled,
    required this.name,
    this.impressionData,
    required this.variant,
  });

  /// Convert from dynamic map to [UnleashToggle] format
  UnleashToggle.fromJson(Map<String, dynamic> json)
      : enabled = json['enabled'] as bool,
        name = json['name'] as String,
        impressionData = json['impressionData'] as bool?,
        variant = UnleashToggleVariant.fromJson(
          json['variant'] as Map<String, dynamic>,
        );

  /// Toggle Status
  final bool enabled;

  /// Toggle Name
  final String name;

  /// Toggle Impression Data
  final bool? impressionData;

  /// Toggle Variant
  final UnleashToggleVariant variant;

  /// Convert from [UnleashToggle] to dynamic format
  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'name': name,
        'impressionData': impressionData,
      };
}

/// Used as a part of [UnleashToggle] to represent variant value of
/// [UnleashToggle].
class UnleashToggleVariant {
  /// Default constructor of [UnleashToggleVariant]
  UnleashToggleVariant({
    required this.name,
    required this.enabled,
    this.payload,
  });

  /// Convert from dynamic map to [UnleashToggleVariant] format
  UnleashToggleVariant.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        enabled = json['enabled'] as bool,
        payload = json['payload'] != null
            ? UnleashToggleVariantPayload.fromJson(
                json['payload'] as Map<String, dynamic>,
              )
            : null;

  /// Variant Name
  final String name;

  /// Variant enabled status
  final bool enabled;

  /// Variant payload value
  final UnleashToggleVariantPayload? payload;
}

/// Unleash Toggle Variant Payload
class UnleashToggleVariantPayload {
  /// Unleash toggle variant payload constructor
  UnleashToggleVariantPayload({required this.type, required this.value});

  /// Convert from dynamic map to [UnleashToggleVariantPayload] format
  UnleashToggleVariantPayload.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        value = json['value'] as String;

  /// Variant Type
  /// It could be json or text
  final String type;

  /// Variant Value
  final String value;
}
