import 'dart:async';
import 'dart:developer';

/// [Logger] is helper class
class Logger {
  static const String _name = 'UnleashProxy';

  /// Emit a log event.
  ///
  /// This function was designed to map closely to the logging information
  /// collected by `package:logging`.
  ///
  /// - [message] is the log message
  /// - [time] (optional) is the timestamp
  /// - [sequenceNumber] (optional) is a monotonically increasing sequence
  ///   number
  /// - [level] (optional) is the severity level (a value between 0 and 2000);
  ///   see the `package:logging` `Level` class for an overview of the possible
  ///   values
  /// - [zone] (optional) the zone where the log was emitted
  /// - [error] (optional) an error object associated with this log event
  /// - [stackTrace] (optional) a stack trace associated with this log event
  static void writeLn(
    String message, {
    int? sequenceNumber,
    int level = 0,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      log(
        message,
        time: DateTime.now(),
        sequenceNumber: sequenceNumber,
        level: level,
        name: _name,
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );

  ///
  static void writeInfo(
    String message, {
    int? sequenceNumber,
    Zone? zone,
    StackTrace? stackTrace,
  }) {
    writeLn(
      message,
      sequenceNumber: sequenceNumber,
      level: LoggerLevel.info,
      zone: zone,
      stackTrace: stackTrace,
    );
  }

  ///
  static void writeError(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    writeLn(
      message,
      sequenceNumber: sequenceNumber,
      level: LoggerLevel.severe,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

/// [LoggerLevel]
class LoggerLevel {
  /// Special key to turn on all logging.
  static const int all = 0;

  /// Special key to turn off all logging 2000.
  static const int off = 2000;

  /// Key for highly detailed tracing 300.
  static const int finest = 300;

  /// Key for fairly detailed tracing 400.
  static const int finer = 400;

  /// Key for tracing information 500.
  static const int fine = 500;

  /// Key for static configuration messages 700.
  static const int config = 700;

  /// Key for informational messages 800.
  static const int info = 800;

  /// Key for potential problems 900.
  static const int warning = 900;

  /// Key for serious failures 1000.
  static const int severe = 1000;

  /// Key for extra debugging loudness 1200.
  static const int shout = 1200;
}
