library verbal_expressions.range;

///
/// Represents a range object, which is used to setup validation ranges
/// 
class Range {
  /// Creates a [Range] object based on [from] and [to] values
  Range(this.from, this.to) {
    if (from.isEmpty) {
      throw ArgumentError.notNull('from');
    }

    if (to.isEmpty) {
      throw ArgumentError.notNull('to');
    }
  }

  /// Start range point
  String from;

  /// End range point
  String to;
}
