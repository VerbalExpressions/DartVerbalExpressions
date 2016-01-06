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

    return value;
  }

  VerbalExpressions startOfLine([bool enable = true]) {
    this._prefixes = enable ? '^' : '';
    return this;
  }

  VerbalExpressions endOfLine([bool enable = true]) {
    this._suffixes = enable ? '\$' : '';
    return this;
  }

  String toString(){
    return '$_prefixes$_source$_suffixes';
  }

  bool isMatch(String value) {
    return true;
  }

  VerbalExpressions add(String value) {
    _source += value;
    return this;
  }

  VerbalExpressions maybe(String value, [bool toSanitize = true]) {
    value = toSanitize ? sanitize(value) : value;
    return add('($value)?');
  }

  VerbalExpressions then(String value, [bool toSanitize = true]) {
    value = toSanitize ? sanitize(value) : value;
    return add('($value)');
  }
}
