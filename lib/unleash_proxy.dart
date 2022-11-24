// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

/// A Very Good Project created by Very Good CLI.
library unleash_proxy;

import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:unleash_proxy/src/data/response.dart';
import 'package:unleash_proxy/src/platform/unleash_app_platform.dart';
import 'package:unleash_proxy/src/platform/unleash_platform.dart';
import 'package:unleash_proxy/src/utils.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

export 'src/client.dart';
export 'src/config.dart';
export 'src/context.dart';
export 'src/data/bootstrap.dart';
export 'src/data/toggle.dart';
export 'src/polling/polling.dart';

part 'src/unleash.dart';
part 'src/unleash_app.dart';
