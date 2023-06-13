/// Result class to handle fetch success or failure from server
abstract class Result<T> {}

/// Wrap successful fetch result
class Success<T> extends Result<T> {
  /// Constructor to wrap data from successful fetch
  Success(this._data);

  final T? _data;

  /// Getter for data of successful fetch
  T? get data => _data;
}

/// Wrap failed fetch result
class Error<T> extends Result<T> {
  /// Constructor to convert object to exception
  Error(Object error) {
    if (error is Exception) {
      _error = error;
    } else {
      // to prevent stack overflow just print the class name
      // if the error class is unknown
      final message = error is String ? error : error.runtimeType.toString();
      _error = Exception('Unknown error: $message');
    }
  }
  late final Exception _error;

  /// Getter for exception of failed fetch
  Exception get error => _error;
}
