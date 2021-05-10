///
///
///
library verbal_expressions.verbal_expression;

import 'package:verbal_expressions/src/range.dart';

///
/// Represents a VerbalExpression
///
class VerbalExpression {
  ///
  String _prefixes = '';

  ///
  final _sources = [''];

  ///
  String _suffixes = '';

  ///
  bool _ignoreCase = false;

  ///
  bool _isMultiLine = true;

  ///
  bool _isGlobal = true;

  /// Escapes any non-word char with two backslashes used by any method, except [this.add]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns sanitized string value.
  ///
  /// Example:
  ///   sanitize('.\$^{abc 123'); // \\.\\$\\^\\{abc\\ 123
  ///
  String sanitize(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Value is empty');
    }

    return _escape(value);
  }

  String _escape(String value) {
    const pattern = '[\\W]';
    return value.replaceAllMapped(RegExp(pattern), (Match match) {
      return '\\${match.group(0)}';
    });
  }

  /// Append literal expression
  ///
  /// Everything added to the expression should go trough this method
  /// (keep in mind when creating your own methods).
  /// All existing methods already use this, so for basic usage, you can just ignore this method.
  ///
  /// Example:
  ///   var expression = VerbalExpression()..add('\n.*');
  ///   expression.toRegExp(); // produce exact '\n.*' regexp
  ///
  void add(String expression) {
    _sources[_sources.length - 1] += expression;
  }

  /// Mark the expression to start at the beginning of the line
  ///
  /// Enable or disable the expression to start at the beginning of the line using [enable] flag
  ///
  /// Example:
  ///   var expression = VerbalExpression()..startOfLine()..add('abc');
  ///   expression.toRegExp(); // produce '^abc' regexp
  ///
  void startOfLine([bool enable = true]) {
    _prefixes = enable ? '^' : '';
  }

  /// Mark the expression to end at the last character of the line
  ///
  /// Enable or disable the expression to end at the last character of the line using [enable] flag
  ///
  /// Example:
  ///   var expression = VerbalExpression()..add('abc')..endOfLine();
  ///   expression.toRegExp(); // produce 'abc\$' regexp
  ///
  void endOfLine([bool enable = true]) {
    _suffixes += enable ? '\$' : '';
  }

  /// Adds a string to the expression that might appear once (or not)
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  ///
  /// Example:
  /// The following matches all strings that contain http:// or https://
  ///   var expression = VerbalExpression()
  ///     ..find('http')
  ///     ..maybe('s')
  ///     ..then('://')
  ///     ..anythingBut(' ');
  ///   expression.hasMatch('http://')    //true
  ///   expression.hasMatch('https://')   //true
  ///
  void maybe(String value) {
    add('(?:${sanitize(value)})?');
  }

  /// Adds a string to the expression
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  ///
  /// Example:
  ///   var expression = VerbalExpression()..then('abc');
  ///   expression.toRegExp(); // produce 'abc' regexp
  ///
  void then(String value) {
    add(sanitize(value));
  }

  /// Adds a string to the expression
  ///
  /// Syntax sugar for [this.then]. Use it in case when it goes first.
  /// Throws an [ArgumentError] if [value] is null or empty.
  ///
  /// Example:
  ///   var expression = VerbalExpression()..find('abc');
  ///   expression.toRegExp(); // produce 'abc' regexp
  ///
  void find(String value) {
    then(value);
  }

  /// Adds expression that matches anything (includes empty string)
  ///
  /// [isLazy] determines the type of search. Greedy search is default.
  ///
  /// Example:
  ///   Input: 'greedy can be dangerous at times'
  ///   ..add('a')..anything()..then('a')      // 'an be dangerous a'
  ///   ..add('a')..anything(true)..then('a')  // 'an be da'
  ///
  void anything([bool isLazy = false]) {
    add(isLazy ? '(?:.*?)' : '(?:.*)');
  }

  /// Adds expression that matches anything, but not [value]
  ///
  /// [isLazy] determines the type of search. Greedy search is default.
  /// Throws an [ArgumentError] if [value] is null or empty.

  void anythingBut(String value, [bool isLazy = false]) {
    add('(?:[^${sanitize(value)}]${isLazy ? '*?' : '*'})');
  }

  /// Adds expression that matches something that might appear once (or more)
  void something() {
    add('(?:.+)');
  }

  /// Adds expression that matches something that might appear once (or more),
  /// but not [value]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  void somethingBut(String value) {
    add('(?:[^${sanitize(value)}]+)');
  }

  /// Adds universal (Unix + Windows CRLF + Macintosh) line break expression
  void lineBreak() {
    add('(?:\\r\\n|\\r|\\n|\\r\\r)');
  }

  /// Shortcut for [this.lineBreak()]
  void br() {
    lineBreak();
  }

  /// Adds expression to match a tab character ('\u0009')
  void tab() {
    add('\\t');
  }

  /// Adds word, same as [a-zA-Z_0-9]+
  void word() {
    add('\\w+');
  }

  /// Adds word character, same as [a-zA-Z_0-9]
  void wordChar() {
    add('\\w');
  }

  /// Adds non-word character, same as [^\w]
  void nonWordChar() {
    add('\\W');
  }

  /// Adds digit, same as [0-9]
  void digit() {
    add('\\d');
  }

  /// Adds non-digit, same as [^0-9]
  void nonDigit() {
    add('\\D');
  }

  /// Adds whitespace character, same as [ \t\n\x0B\f\r]
  void space() {
    add('\\s');
  }

  /// Adds non-whitespace character, same as [^\s]
  void nonSpace() {
    add('\\S');
  }

  /// Adds expression that any character from [value]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  void anyOf(String value) {
    add('[${sanitize(value)}]');
  }

  /// Shorthand for [this.anyOf()]
  void any(String value) {
    anyOf(value);
  }

  /// Add expression to match a range (or multiply ranges)
  ///
  /// Example:
  ///   var expression = VerbalExpression()
  ///     ..range([Range('a', 'f'), Range('0', '5')]);
  ///   expression.toRegExp(); // produce [a-f0-5]
  ///
  void range(List<Range> ranges) {
    String result = '[';
    ranges.forEach((Range range) {
      result += '${sanitize(range.from)}-${sanitize(range.to)}';
    });

    result += ']';

    add(result);
  }

  /// Adds modifier flag
  ///
  /// Allows to set 'g', 'm' and 'i' flags in the regex
  /// Throws an [ArgumentError] if [modifier] is other then 'g', 'm' or 'i'.
  /// 'gm' is default.
  void addModifier(String modifier) {
    _applyModifier(modifier, true);
  }

  /// Removes modifier flag
  ///
  /// Allows to unset 'g', 'm' and 'i' flags in the regex
  /// Throws an [ArgumentError] if [modifier] is other then 'g', 'm' or 'i'.
  /// 'gm' is default.
  void removeModifier(String modifier) {
    _applyModifier(modifier, false);
  }

  void _applyModifier(String modifier, bool enable) {
    switch (modifier) {
      case 'i':
        _ignoreCase = enable;
        break;
      case 'm':
        _isMultiLine = enable;
        break;
      case 'g':
        _isGlobal = enable;
        break;
      default:
        throw ArgumentError('Unsupported modifier "$modifier"');
    }
  }

  /// Enable or disable matching with ignoring case according to [enable] flag.
  ///
  /// Case sensitive matching is default.
  ///
  /// Example:
  ///   var regex = VerbalExpression()..find('a')..withAnyCase();
  ///   regex.hasMatch('a')   //true
  ///   regex.hasMatch('A')   //true
  ///
  void withAnyCase([bool enable = true]) {
    _applyModifier('i', enable);
  }

  /// Enable or disable search in one line in prior
  /// to multi line search according to [enable] flag.
  ///
  /// Multi line search is default.
  ///
  /// Example:
  ///   var regex = VerbalExpression()..find('a')..searchOneLine();
  ///   regex.hasMatch('first line \n a') //false
  ///   regex.hasMatch('a')               //true
  ///
  void searchOneLine([bool enable = true]) {
    _applyModifier('m', !enable);
  }

  /// Enable or disable search only for a first match in prior
  /// to all matches according to [enable] flag.
  ///
  /// Global (all matches) search is default.
  ///
  /// Example:
  ///   var expression = VerbalExpression()..find('a')..stopAtFirst();
  ///   expression.replace('b') // baa
  ///   expression.stopAtFirst(false);
  ///   expression.replace('b') // bbb
  ///
  void stopAtFirst([bool enable = true]) {
    _applyModifier('g', !enable);
  }

  /// Adds '+' char to regexp, means one or more times repeated
  ///
  /// Same effect as [this.atLeast(1)]
  void oneOrMore() {
    add('+');
  }

  /// Adds zero or more times repeater.
  ///
  /// [isLazy] determines the type of search. Greedy search is default.
  ///
  /// Example:
  ///   Input: 'greedy can be dangerous at times'
  ///   ..add('a.')..zeroOrMore()..then('a')      // 'an be dangerous a'
  ///   ..add('a.')..zeroOrMore(true)..then('a')  // 'an be da'
  ///
  void zeroOrMore([bool isLazy = false]) {
    add(isLazy ? '*?' : '*');
  }

  /// Add count of previous group
  ///
  /// Example:
  ///   var regex = VerbalExpression()
  ///     ..startOfLine()
  ///     ..find('a')
  ///     ..count(3)
  ///     ..endOfLine();
  ///   regex.hasMatch('aa')  //false
  ///   regex.hasMatch('aaa') //true
  ///
  void count(int? count) {
    add('{$count}');
  }

  /// Add count of previous group
  ///
  /// Example:
  ///   var regex = VerbalExpression()
  ///     ..startOfLine()
  ///     ..find('a')
  ///     ..countRange(2,4)
  ///     ..endOfLine();
  ///   regex.hasMatch('aa')    //true
  ///   regex.hasMatch('aaaa')  //true
  ///   regex.hasMatch('aaaaa') //false
  ///
  void countRange(int min, int max) {
    add('{$min,$max}');
  }

  /// Produce range count with only minimal number of occurrences
  ///
  /// [min] is minimal number of occurrences
  ///
  /// Example:
  ///   var regex = VerbalExpression()
  ///     ..startOfLine()
  ///     ..find('a')
  ///     ..atLeast(2)
  ///     ..endOfLine();
  ///   regex.hasMatch('a')    //false
  ///   regex.hasMatch('aaa')  //true
  ///
  void atLeast(int min) {
    add('{$min,}');
  }

  /// Convenient method to show that string usage count is exact count, range count or simply one or more
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  ///
  /// Example:
  /// .multiply('abc')                    // Produces (abc)+
  /// .multiply('abc', min: 2)            // Produces (abc){2}
  /// .multiply('abc', max: 5)            // Produces (abc){,5}
  /// .multiply('abc', min: 2, max: 5)    // Produces (abc){2,5}
  ///
  void multiple(String value, {int? min, int? max}) {
    then(value);

    if (min == null && max == null) {
      oneOrMore();
      return;
    }

    if (max == null) {
      count(min);
      return;
    }

    if (min == null) {
      countRange(1, max);
      return;
    }

    countRange(min, max);
  }

  /// Starts a capturing group
  void beginCapture() {
    add('(');
    _sources.add('');
  }

  /// Ends a capturing group
  ///
  /// Throws an [StateError] if call this method before call beginCapture().
  void endCapture() {
    if (_sources.length == 1)
      throw StateError(
          'There is no started group capture. Call beginCapture() first.');

    _sources[_sources.length - 2] += '${_sources.last})';
    _sources.removeLast();
  }

  /// Add a alternative expression to be matched
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  void or(String value) {
    _sources[_sources.length - 1] = '(?:${_sources.last}';
    add(')|(?:');
    _suffixes += ')';
    then(value);
  }

  /// Shorthand function for the String.replace functions
  ///
  /// Takes into account global modifier
  /// Throws an [ArgumentError] if [value] or [source] is null or empty.
  /// Returns replaced string.
  String replace(String source, String value) {
    if (_isGlobal) {
      return source.replaceAll(toRegExp(), value);
    }

    return source.replaceFirst(toRegExp(), value);
  }

  /// Convert to RegExp
  ///
  /// Returns resulting regex object
  RegExp toRegExp() {
    String source =
        _sources.reduce((String result, String item) => result + item);

    for (int i = 0; i < _sources.length - 1; i++) {
      source += ')';
    }

    return RegExp('$_prefixes$source$_suffixes',
        caseSensitive: !_ignoreCase, multiLine: _isMultiLine);
  }

  /// Overrides toString
  ///
  /// Returns resulting regex pattern
  @override
  String toString() {
    return toRegExp().pattern;
  }

  /// Shorthand function for the Regex.hasMatch function
  ///
  /// Returns matching result.
  bool hasMatch(String value) {
    return toRegExp().hasMatch(value);
  }
}
