/// Represents a failure that occurred during an operation.
class Failure {
  /// Constructs a Failure instance.
  const Failure({this.code = 200, required this.message, this.stackTrace});

  /// The error code associated with the failure.
  final int code;

  /// A message describing the failure.
  final String message;

  /// The stack trace associated with the failure, if available.
  final StackTrace? stackTrace;
}
