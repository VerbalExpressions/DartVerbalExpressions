library verbal_expressions.range;

/// Represents a range object, which is used to setup validation ranges
class Range {

  /// Start range point
  String from;
  /// End range point
  String to;
  
  /// Creates a [Range] object based on [from] and [to] values
  Range(this.from, this.to) {
    if (from == null || from.isEmpty)
      throw ArgumentError.notNull('from');
    
    if (to == null || to.isEmpty)
      throw ArgumentError.notNull('to');
  }
}
