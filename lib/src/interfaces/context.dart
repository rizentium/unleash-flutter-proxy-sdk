/// Unleash Context
class UnleashContext {
  /// Unleash Context constructor
  UnleashContext({this.appName, this.userId, this.sessionId, this.properties});

  /// Unleash App Name
  final String? appName;

  /// Unleash User ID
  final String? userId;

  /// Unleash Session ID
  final String? sessionId;

  /// Unleash additional properties
  final Map<String, String>? properties;

  /// Context Query Params
  String get queryParams {
    final params = <String, String>{};

    if (appName != null) {
      params.putIfAbsent('appName', () => appName!);
    }

    if (userId != null) {
      params.putIfAbsent('userId', () => userId!);
    }

    if (sessionId != null) {
      params.putIfAbsent('sessionId', () => sessionId!);
    }

    params.addAll(properties ?? {});

    return Uri(queryParameters: params).query;
  }
}
