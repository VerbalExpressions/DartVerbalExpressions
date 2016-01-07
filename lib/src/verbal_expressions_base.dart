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

  VerbalExpressions add(String value, [bool toSanitize = true]) {
    value = toSanitize ? sanitize(value) : value;
    _source += value;
    return this;
  }

  VerbalExpressions maybe(String value, [bool toSanitize = true]) {
    value = toSanitize ? sanitize(value) : value;
    return add('($value)?', false);
  }

  VerbalExpressions then(String value, [bool toSanitize = true]) {
    value = toSanitize ? sanitize(value) : value;
    return add('($value)', false);
  } 

  VerbalExpressions find(String value, [bool toSanitize = true]) {
    return then(value, toSanitize);
  }

  VerbalExpressions anything() {
    return add('(.*)', false);
  }

  String toString(){
    return '$_prefixes$_source$_suffixes';
  }

  bool isMatch(String value) {
    return true;
  }
}
