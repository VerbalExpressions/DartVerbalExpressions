library verbal_expressions.range;

class Range {
  String from;
  String to;

  Range(this.from, this.to){

    if (from == null || from.isEmpty){
      throw new ArgumentError.notNull('from');
    }

    if (to == null || to.isEmpty){
      throw new ArgumentError.notNull('to');
    }
  }
}