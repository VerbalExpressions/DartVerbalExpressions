///
/// The dart_verbal_expressions library.
///
/// A library for Dart developers that helps to construct difficult regular expressions
///
library verbal_expressions.range;

/// Represents a range object, which is used to setup validation ranges
class Range {
  ///
  factory Range(String from, String to) {
    if (from.isEmpty) {
      throw ArgumentError.value(from);
    }

    if (to.isEmpty) {
      throw ArgumentError.value(to);
    }

    return Range._(from, to);
  }

  /// Creates a [Range] object based on [from] and [to] values
  const Range._(this.from, this.to);

  /// Start range point
  final String from;

  /// End range point
  final String to;
}
