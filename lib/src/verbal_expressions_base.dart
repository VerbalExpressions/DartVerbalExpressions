library verbal_expressions.base;

class VerbalExpressions {

  String _prefixes = '';
  String _source = '';
  String _suffixes = '';

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

  VerbalExpressions _addWithoutSanitize(String value, [bool toSanitize = false]) {
    value = toSanitize ? sanitize(value) : value;
    _source += value;
    return this;
  }

  VerbalExpressions maybe(String value) {
    value = sanitize(value);
    return _addWithoutSanitize('($value)?');
  }

  VerbalExpressions then(String value) {
    value = sanitize(value);
    return _addWithoutSanitize('($value)');
  }

  VerbalExpressions find(String value) {
    return then(value);
  }

  VerbalExpressions anything() {
    return _addWithoutSanitize('(.*)');
  }

  String toString(){
    return '$_prefixes$_source$_suffixes';
  }

  bool isMatch(String value) {
    return true;
  }
}
