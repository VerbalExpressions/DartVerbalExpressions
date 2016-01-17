library verbal_expressions.verbal_expression;

import 'package:verbal_expressions/src/range.dart';

class VerbalExpression {
  String _prefixes = '';
  String _source = '';
  String _suffixes = '';

  bool _ignoreCase = false;
  bool _isMultiLine = true;
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
    if (value == null || value.isEmpty) {
      throw new ArgumentError('Value is empty');
    }

    return _escape(value);
  }

  String _escape(String value) {
    var pattern = '[\\W]';
    return value.replaceAllMapped(new RegExp(pattern), (match) {
      return '\\${match.group(0)}';
    });
  }

  /// Append literal expression
  ///
  /// Everything added to the expression should go trough this method
  /// (keep in mind when creating your own methods).
  /// All existing methods already use this, so for basic usage, you can just ignore this method.
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   new VerbalExpression().add('\n.*').toRegExp(); // produce exact '\n.*' regexp
  ///
  VerbalExpression add(String expression) {
    _source += expression;
    return this;
  }

  /// Mark the expression to start at the beginning of the line
  ///
  /// Enable or disable the expression to start at the beginning of the line using [enable] flag
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   new VerbalExpression().startOfLine().add('abc').toRegExp(); // produce '^abc' regexp
  ///
  VerbalExpression startOfLine([bool enable = true]) {
    this._prefixes = enable ? '^' : '';
    return this;
  }

  /// Mark the expression to end at the last character of the line
  ///
  /// Enable or disable the expression to end at the last character of the line using [enable] flag
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   new VerbalExpression().add('abc').endOfLine().toRegExp(); // produce 'abc\$' regexp
  ///
  VerbalExpression endOfLine([bool enable = true]) {
    this._suffixes += enable ? '\$' : '';
    return this;
  }

  /// Adds a string to the expression that might appear once (or not)
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  ///
  /// Example:
  /// The following matches all strings that contain http:// or https://
  ///   var regex = new VerbalExpression()
  ///   .find('http')
  ///   .maybe('s')
  ///   .then('://')
  ///   .anythingBut(' ').toRegExp();
  ///   regex.hasMatch('http://')    //true
  ///   regex.hasMatch('https://')   //true
  ///
  VerbalExpression maybe(String value) {
    return add('(${sanitize(value)})?');
  }

  /// Adds a string to the expression
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   new VerbalExpression().then('abc').toRegExp(); // produce 'abc' regexp
  ///
  VerbalExpression then(String value) {
    return add('${sanitize(value)}');
  }

  /// Adds a string to the expression
  ///
  /// Syntax sugar for [this.then]. Use it in case when it goes first.
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   new VerbalExpression().first('abc').toRegExp(); // produce 'abc' regexp
  ///
  VerbalExpression find(String value) {
    return then(value);
  }

  /// Adds expression that matches anything (includes empty string)
  ///
  /// Returns this verbal expression object.
  VerbalExpression anything() {
    return add('(.*)');
  }

  /// Adds expression that matches anything, but not [value]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  VerbalExpression anythingBut(String value) {
    return add('([^${sanitize(value)}]*)');
  }

  /// Adds expression that matches something that might appear once (or more)
  ///
  /// Returns this verbal expression object.
  VerbalExpression something() {
    return add('(.+)');
  }

  /// Adds expression that matches something that might appear once (or more),
  /// but not [value]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  VerbalExpression somethingBut(String value) {
    return add('([^${sanitize(value)}]+)');
  }

  /// Adds universal (Unix + Windows CRLF) line break expression
  ///
  /// Returns this verbal expression object.
  VerbalExpression lineBreak() {
    return add('(\\r\\n|\\r|\\n)');
  }

  /// Shortcut for [this.lineBreak()]
  ///
  /// Returns this verbal expression object.
  VerbalExpression br() {
    return lineBreak();
  }

  /// Adds expression to match a tab character ('\u0009')
  ///
  /// Returns this verbal expression object.
  VerbalExpression tab() {
    return add('\\t');
  }

  /// Adds word, same as [a-zA-Z_0-9]+
  ///
  /// Returns this verbal expression object.
  VerbalExpression word() {
    return add('\\w+');
  }

  /// Adds word character, same as [a-zA-Z_0-9]
  ///
  /// Returns this verbal expression object.
  VerbalExpression wordChar() {
    return add('\\w');
  }

  /// Adds non-word character, same as [^\w]
  ///
  /// Returns this verbal expression object.
  VerbalExpression nonWordChar() {
    return add('\\W');
  }

  /// Adds digit, same as [0-9]
  ///
  /// Returns this verbal expression object.
  VerbalExpression digit() {
    return add('\\d');
  }

  /// Adds non-digit, same as [^0-9]
  ///
  /// Returns this verbal expression object.
  VerbalExpression nonDigit() {
    return add('\\D');
  }

  /// Adds whitespace character, same as [ \t\n\x0B\f\r]
  ///
  /// Returns this verbal expression object.
  VerbalExpression space() {
    return add('\\s');
  }

  /// Adds non-whitespace character, same as [^\s]
  ///
  /// Returns this verbal expression object.
  VerbalExpression nonSpace() {
    return add('\\S');
  }

  /// Adds expression that any character from [value]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  VerbalExpression anyOf(String value) {
    return add('[${sanitize(value)}]');
  }

  /// Shorthand for [this.anyOf()]
  ///
  /// Returns this verbal expression object.
  VerbalExpression any(String value) {
    return anyOf(value);
  }

  /// Add expression to match a range (or multiply ranges)
  ///
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   var regex = new VerbalExpression()
  ///  .range([new Range('a', 'f'), new Range('0', '5')])
  ///  .toRegExp(); // produce [a-f0-5]
  ///
  VerbalExpression range(List<Range> ranges) {
    var result = '[';
    ranges.forEach((range) {
      result += '${sanitize(range.from)}-${sanitize(range.to)}';
    });

    result += ']';

    return add(result);
  }

  /// Adds modifier flag
  ///
  /// Allows to set 'g', 'm' and 'i' flags in the regex
  /// Throws an [ArgumentError] if [modifier] is other then 'g', 'm' or 'i'.
  /// 'gm' is default.
  /// Returns this verbal expression object.
  VerbalExpression addModifier(String modifier) {
    return _applyModifier(modifier, true);
  }

  /// Removes modifier flag
  ///
  /// Allows to unset 'g', 'm' and 'i' flags in the regex
  /// Throws an [ArgumentError] if [modifier] is other then 'g', 'm' or 'i'.
  /// 'gm' is default.
  /// Returns this verbal expression object.
  VerbalExpression removeModifier(String modifier) {
    return _applyModifier(modifier, false);
  }

  VerbalExpression _applyModifier(String modifier, bool enable) {
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
        throw new ArgumentError('Unsupported modifier "$modifier"');
    }

    return this;
  }

  /// Enable or disable matching with ignoring case according to [enable] flag.
  ///
  /// Case sensitive matching is default.
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   var regex = new VerbalExpression().find('a').withAnyCase().toRegExp();
  ///   regex.hasMatch('a')   //true
  ///   regex.hasMatch('A')   //true
  ///
  VerbalExpression withAnyCase([bool enable = true]) {
    return _applyModifier('i', enable);
  }

  /// Enable or disable search in one line in prior
  /// to multi line search according to [enable] flag.
  ///
  /// Multi line search is default.
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   var regex = new VerbalExpression().find('a').searchOneLine().toRegExp();
  ///   regex.hasMatch('first line \n a') //false
  ///   regex.hasMatch('a')               //true
  ///
  VerbalExpression searchOneLine([bool enable = true]) {
    return _applyModifier('m', !enable);
  }

  /// Enable or disable search only for a first match in prior
  /// to all matches according to [enable] flag.
  ///
  /// Global (all matches) search is default.
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   new VerbalExpression().find('a').stopAtFirst().replace('b') // baa
  ///   new VerbalExpression().find('a').stopAtFirst(false).replace('b') // bbb
  ///
  VerbalExpression stopAtFirst([bool enable = true]) {
    return _applyModifier('g', !enable);
  }

  /// Adds '+' char to regexp, means one or more times repeated
  ///
  /// Same effect as [this.atLeast(1)]
  /// Returns this verbal expression object.
  VerbalExpression oneOrMore() {
    return add('+');
  }

  /// Adds '*' char to regexp, means zero or more times repeated
  ///
  /// Same effect as [this.atLeast(0)]
  /// Returns this verbal expression object.
  VerbalExpression zeroOrMore() {
    return add('*');
  }

  /// Add count of previous group
  ///
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   var regex = new VerbalExpression()
  ///   .startOfLine()
  ///   .find('a')
  ///   .count(3)
  ///   .endOfLine()
  ///   .toRegExp();
  ///   regex.hasMatch('aa')  //false
  ///   regex.hasMatch('aaa') //true
  ///
  VerbalExpression count(int count) {
    return add('{$count}');
  }

  /// Add count of previous group
  ///
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   var regex = new VerbalExpression()
  ///   .startOfLine()
  ///   .find('a')
  ///   .countRange(2,4)
  ///   .endOfLine()
  ///   .toRegExp();
  ///   regex.hasMatch('aa')    //true
  ///   regex.hasMatch('aaaa')  //true
  ///   regex.hasMatch('aaaaa') //false
  ///
  VerbalExpression countRange(int min, int max) {
    return add('{$min,$max}');
  }

  /// Produce range count with only minimal number of occurrences
  ///
  /// [min] is minimal number of occurrences
  /// Returns this verbal expression object.
  ///
  /// Example:
  ///   var regex = new VerbalExpression()
  ///   .startOfLine()
  ///   .find('a')
  ///   .atLeast(2)
  ///   .endOfLine()
  ///   .toRegExp();
  ///   regex.hasMatch('a')    //false
  ///   regex.hasMatch('aaa')  //true
  ///
  VerbalExpression atLeast(int min) {
    return add('{$min,}');
  }

  /// Convenient method to show that string usage count is exact count, range count or simply one or more
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  ///
  /// Example:
  /// .multiply('abc')                    // Produces (abc)+
  /// .multiply('abc', min: 2)            // Produces (abc){2}
  /// .multiply('abc', max: 5)            // Produces (abc){,5}
  /// .multiply('abc', min: 2, max: 5)    // Produces (abc){2,5}
  ///
  VerbalExpression multiple(String value, {int min, int max}) {
    if (min == null && max == null) return then(value).oneOrMore();

    if (max == null) return then(value).count(min);

    if (min == null) return then(value).countRange(1, max);

    return then(value).countRange(min, max);
  }

  /// Starts a capturing group
  ///
  /// Returns this verbal expression object.
  VerbalExpression beginCapture() {
    _suffixes = ')$_suffixes';
    return add('(');
  }

  /// Ends a capturing group
  ///
  /// Returns this verbal expression object.
  VerbalExpression endCapture() {
    // Remove the last parentheses from the _suffixes and add to the regex itself
    _suffixes = _suffixes.substring(0, _suffixes.length - 1);
    return add(')');
  }

  /// Add a alternative expression to be matched
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns this verbal expression object.
  VerbalExpression or(String value) {
    _prefixes += '(';
    _suffixes = ')$_suffixes';
    return add(')|(').then(value);
  }

  /// Shorthand function for the String.replace functions
  ///
  /// Takes into account global modifier
  /// Throws an [ArgumentError] if [value] or [source] is null or empty.
  /// Returns this verbal expression object.
  String replace(String source, String value) {
    if (source == null) throw new ArgumentError.notNull('source');
    if (value == null) throw new ArgumentError.notNull('value');

    if (_isGlobal) return source.replaceAll(this.toRegExp(), value);

    return source.replaceFirst(this.toRegExp(), value);
  }

  /// Convert to RegExp
  ///
  /// Returns resulting regex object
  RegExp toRegExp() {
    return new RegExp('$_prefixes$_source$_suffixes',
        caseSensitive: !_ignoreCase, multiLine: _isMultiLine);
  }

  /// Overrides toString
  ///
  /// Returns resulting regex pattern
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
