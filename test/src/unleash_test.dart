// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:unleash_flutter_proxy_sdk/unleash.dart';

void main() {
  group('Unleash', () {
    test('can be instantiated', () {
      expect(Unleash(), isNotNull);
    });
  });
}
