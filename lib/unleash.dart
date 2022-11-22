// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

/// A Very Good Project created by Very Good CLI.
library unleash_flutter_proxy_sdk;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:unleash_flutter_proxy_sdk/src/client.dart';
import 'package:unleash_flutter_proxy_sdk/src/config.dart';
import 'package:unleash_flutter_proxy_sdk/src/context.dart';
import 'package:unleash_flutter_proxy_sdk/src/data/toggle.dart';
import 'package:unleash_flutter_proxy_sdk/src/platform/unleash_app_platform.dart';
import 'package:unleash_flutter_proxy_sdk/src/platform/unleash_platform.dart';
import 'package:unleash_flutter_proxy_sdk/src/polling/polling.dart';
import 'package:unleash_flutter_proxy_sdk/src/utils.dart';

export 'src/client.dart';
export 'src/config.dart';
export 'src/context.dart';
export 'src/polling/polling.dart';

part 'src/unleash.dart';
part 'src/unleash_app.dart';
