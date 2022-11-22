import 'dart:developer';

/// Unleash utilities
class Utils {
  /// unleash logger function
  static void logger(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      log(
        message,
        name: 'unleash',
        error: error,
        stackTrace: stackTrace,
      );
}
