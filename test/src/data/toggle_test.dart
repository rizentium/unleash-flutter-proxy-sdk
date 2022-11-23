// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:unleash_proxy/src/data/toggle.dart';

void main() {
  group('Unleash Data', () {
    test('can convert fromJson to UnleashToggle', () async {
      const payload = '{'
          '"name": "toggle-with-variants", '
          '"enabled": true, '
          '"variant": {"name": "simple","enabled": true} '
          '}';

      final decode = jsonDecode(payload) as Map<String, dynamic>;

      final source = UnleashToggle.fromJson(decode);

      final expected = UnleashToggle(
        enabled: true,
        name: 'toggle-with-variants',
        variant: UnleashToggleVariant(name: 'simple', enabled: true),
      );

      expect(source.name, equals(expected.name));
      expect(source.enabled, equals(expected.enabled));
      expect(source.impressionData, equals(expected.impressionData));
      expect(source.variant.name, equals(expected.variant.name));
      expect(source.variant.enabled, equals(expected.variant.enabled));
      expect(
        source.variant.payload?.type,
        equals(expected.variant.payload?.type),
      );
      expect(
        source.variant.payload?.value,
        equals(expected.variant.payload?.value),
      );
    });
  });
}
