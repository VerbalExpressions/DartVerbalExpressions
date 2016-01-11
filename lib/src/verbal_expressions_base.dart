library verbal_expressions.base;

class VerbalExpressions {

  String _prefixes = '';
  String _source = '';
  String _suffixes = '';

  bool _ignoreCase = false;
  bool _isMultiLine = true;
  bool _isGlobal = false;

  String sanitize(String value)
  {
    if (value == null || value.isEmpty)
    {
      throw new ArgumentError('Value is empty');
    }

    return _escape(value);
  }

  String _escape(String value){
    var pattern = '[\\.|\\\$|\\^|\\{|\\[|\\(|\\||\\)|\\*|\\+|\\?|\\\\]';
    return value.replaceAllMapped(new RegExp(pattern), (match) {
      return '\\${match.group(0)}';
    });
  }

  VerbalExpressions startOfLine([bool enable = true]) {
    this._prefixes = enable ? '^' : '';
    return this;
  }

  VerbalExpressions endOfLine([bool enable = true]) {
    this._suffixes = enable ? '\$' : '';
    return this;
  }

  VerbalExpressions _add(String expression) {
    _source += expression;
    return this;
  }

  VerbalExpressions maybe(String value) {
    return _add('(${sanitize(value)})?');
  }

  VerbalExpressions then(String value) {
    return _add('(${sanitize(value)})');
  }

  VerbalExpressions find(String value) {
    return then(value);
  }

  VerbalExpressions anything() {
    return _add('(.*)');
  }

  VerbalExpressions anythingBut(String value) {
    return _add('([^${sanitize(value)}]*)');
  }

  VerbalExpressions something() {
    return _add('(.+)');
  }

  VerbalExpressions somethingBut(String value) {
    return _add('([^${sanitize(value)}]+)');
  }

  VerbalExpressions lineBreak() {
    return _add('(\\r\\n|\\r|\\n)'); // Unix + Windows CRLF
  }

  VerbalExpressions br() {
    return lineBreak(); // Unix + Windows CRLF
  }

  VerbalExpressions tab() {
    return _add('\\t');
  }

  VerbalExpressions word() {
    return _add('\\w+');
  }

  VerbalExpressions wordChar() {
    return _add('\\w');
  }

  VerbalExpressions nonWordChar() {
    return _add('\\W');
  }

  VerbalExpressions digit() {
    return _add('\\d');
  }

  VerbalExpressions nonDigit() {
    return _add('\\D');
  }

  VerbalExpressions space() {
    return _add('\\s');
  }

  VerbalExpressions nonSpace() {
    return _add('\\S');
  }

  VerbalExpressions anyOf(String value) {
    return _add('[${sanitize(value)}]');
  }

  VerbalExpressions any(String value) {
    return anyOf(value);
  }

  VerbalExpressions range(List<Range> ranges) {

    var result = '[';
    ranges.forEach((range){
      result += '${sanitize(range.from)}-${sanitize(range.to)}';
    });

    result += ']';

    return _add(result);
  }

  VerbalExpressions addModifier(String modifier){
    return _applyModifier(modifier, true);
  }

  VerbalExpressions removeModifier(String modifier){
    return _applyModifier(modifier, false);
  }

  VerbalExpressions _applyModifier(String modifier, bool enable){

    switch(modifier){
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

  VerbalExpressions withAnyCase([bool enable=true]){
    return _applyModifier('i', enable);
  }

  VerbalExpressions searchOneLine([bool enable=true]){
    return _applyModifier('m', !enable);
  }

  VerbalExpressions stopAtFirst([bool enable=true]){
    return _applyModifier('g', !enable);
  }

  VerbalExpressions oneOrMore(){
    return _add('+');
  }

  VerbalExpressions zeroOrMore(){
    return _add('*');
  }

  VerbalExpressions count(int count){
    return _add('{$count}');
  }

  VerbalExpressions countRange(int from, int to){
    return _add('{$from,$to}');
  }

  VerbalExpressions atLeast(int from){
    return _add('{$from,}');
  }

  String replace(String source, String value){

    if (source == null) throw new ArgumentError.notNull('source');
    if (value == null) throw new ArgumentError.notNull('value');

    if (_isGlobal)
      return source.replaceAll(this.toRegExp(), value);

    return source.replaceFirst(this.toRegExp(), value);
  }

  RegExp toRegExp(){
    return new RegExp('$_prefixes$_source$_suffixes', caseSensitive: !_ignoreCase, multiLine: _isMultiLine);
  }

  String toString(){
    return toRegExp().pattern;
  }

  bool isMatch(String value) {
    return true;
  }
}

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