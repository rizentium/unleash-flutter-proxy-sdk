/// Unleash Context
class UnleashContext {
  /// Unleash Context constructor
  UnleashContext({this.appName, this.userId, this.sessionId});

  /// Unleash App Name
  final String? appName;

  /// Unleash User ID
  final String? userId;

  /// Unleash Session ID
  final String? sessionId;

  /// Context Query Params
  String get queryParams {
    const params = <String>[];

    if (appName != null) {
      params.add('appName=$appName');
    }

    if (userId != null) {
      params.add('userId=$userId');
    }

    if (sessionId != null) {
      params.add('sessionId=$sessionId');
    }

    return params.join('&');
  }
}
