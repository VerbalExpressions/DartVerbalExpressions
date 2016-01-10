library verbal_expressions.base;

class VerbalExpressions {

  String _prefixes = '';
  String _source = '';
  String _suffixes = '';

  bool _ignoreCase = false;
  bool _isMultiLine = false;

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

  VerbalExpressions add(String value) {
    _source += sanitize(value);
    return this;
  }

  VerbalExpressions _addWithoutSanitize(String value) {
    _source += value;
    return this;
  }

  VerbalExpressions maybe(String value) {
    return _addWithoutSanitize('(${sanitize(value)})?');
  }

  VerbalExpressions then(String value) {
    return _addWithoutSanitize('(${sanitize(value)})');
  }

  VerbalExpressions find(String value) {
    return then(value);
  }

  VerbalExpressions anything() {
    return _addWithoutSanitize('(.*)');
  }

  VerbalExpressions anythingBut(String value) {
    return _addWithoutSanitize('([^${sanitize(value)}]*)');
  }

  VerbalExpressions something() {
    return _addWithoutSanitize('(.+)');
  }

  VerbalExpressions somethingBut(String value) {
    return _addWithoutSanitize('([^${sanitize(value)}]+)');
  }

  VerbalExpressions lineBreak() {
    return _addWithoutSanitize('(\\r\\n|\\r|\\n)'); // Unix + Windows CRLF
  }

  VerbalExpressions br() {
    return lineBreak(); // Unix + Windows CRLF
  }

  VerbalExpressions tab() {
    return _addWithoutSanitize('\\t');
  }

  VerbalExpressions word() {
    return _addWithoutSanitize('\\w+');
  }

  VerbalExpressions wordChar() {
    return _addWithoutSanitize('\\w');
  }

  VerbalExpressions nonWordChar() {
    return _addWithoutSanitize('\\W');
  }

  VerbalExpressions digit() {
    return _addWithoutSanitize('\\d');
  }

  VerbalExpressions nonDigit() {
    return _addWithoutSanitize('\\D');
  }

  VerbalExpressions space() {
    return _addWithoutSanitize('\\s');
  }

  VerbalExpressions nonSpace() {
    return _addWithoutSanitize('\\S');
  }

  VerbalExpressions anyOf(String value) {
    return _addWithoutSanitize('[${sanitize(value)}]');
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

    return _addWithoutSanitize(result);
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
      default:
        throw new ArgumentError('Unsupported modifier "$modifier"');
    }

    return this;
  }

  VerbalExpressions withAnyCase([bool enable=true]){
    return _applyModifier('i', enable);
  }

  VerbalExpressions multiLineSearch([bool enable=true]){
    return _applyModifier('m', enable);
  }

  VerbalExpressions oneOrMore(){
    return _addWithoutSanitize('+');
  }

  VerbalExpressions zeroOrMore(){
    return _addWithoutSanitize('*');
  }

  VerbalExpressions count(int count){
    return _addWithoutSanitize('{$count}');
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