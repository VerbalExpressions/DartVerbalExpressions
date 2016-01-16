library verbal_expressions.base;
import 'package:verbal_expressions/src/range.dart';

class VerbalExpression {

  String _prefixes = '';
  String _source = '';
  String _suffixes = '';

  bool _ignoreCase = false;
  bool _isMultiLine = true;
  bool _isGlobal = false;

  /// Escapes any non-word char with two backslashes used by any method, except [this.add]
  ///
  /// Throws an [ArgumentError] if [value] is null or empty.
  /// Returns escaped string.
  ///
  ///   sanitize('.\$^{abc 123'); // \\.\\$\\^\\{abc\\ 123
  String sanitize(String value)
  {
    if (value == null || value.isEmpty)
    {
      throw new ArgumentError('Value is empty');
    }

    return _escape(value);
  }

  String _escape(String value){
    var pattern = '[\\W]';
    return value.replaceAllMapped(new RegExp(pattern), (match) {
      return '\\${match.group(0)}';
    });
  }

  VerbalExpression startOfLine([bool enable = true]) {
    this._prefixes = enable ? '^' : '';
    return this;
  }

  VerbalExpression endOfLine([bool enable = true]) {
    this._suffixes += enable ? '\$' : '';
    return this;
  }

  VerbalExpression add(String expression) {
    _source += expression;
    return this;
  }

  VerbalExpression maybe(String value) {
    return add('(${sanitize(value)})?');
  }

  VerbalExpression then(String value) {
    return add('${sanitize(value)}');
  }

  VerbalExpression find(String value) {
    return then(value);
  }

  VerbalExpression anything() {
    return add('(.*)');
  }

  VerbalExpression anythingBut(String value) {
    return add('([^${sanitize(value)}]*)');
  }

  VerbalExpression something() {
    return add('(.+)');
  }

  VerbalExpression somethingBut(String value) {
    return add('([^${sanitize(value)}]+)');
  }

  VerbalExpression lineBreak() {
    return add('(\\r\\n|\\r|\\n)'); // Unix + Windows CRLF
  }

  VerbalExpression br() {
    return lineBreak(); // Unix + Windows CRLF
  }

  VerbalExpression tab() {
    return add('\\t');
  }

  VerbalExpression word() {
    return add('\\w+');
  }

  VerbalExpression wordChar() {
    return add('\\w');
  }

  VerbalExpression nonWordChar() {
    return add('\\W');
  }

  VerbalExpression digit() {
    return add('\\d');
  }

  VerbalExpression nonDigit() {
    return add('\\D');
  }

  VerbalExpression space() {
    return add('\\s');
  }

  VerbalExpression nonSpace() {
    return add('\\S');
  }

  VerbalExpression anyOf(String value) {
    return add('[${sanitize(value)}]');
  }

  VerbalExpression any(String value) {
    return anyOf(value);
  }

  VerbalExpression range(List<Range> ranges) {

    var result = '[';
    ranges.forEach((range){
      result += '${sanitize(range.from)}-${sanitize(range.to)}';
    });

    result += ']';

    return add(result);
  }

  VerbalExpression addModifier(String modifier){
    return _applyModifier(modifier, true);
  }

  VerbalExpression removeModifier(String modifier){
    return _applyModifier(modifier, false);
  }

  VerbalExpression _applyModifier(String modifier, bool enable){

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

  VerbalExpression withAnyCase([bool enable=true]){
    return _applyModifier('i', enable);
  }

  VerbalExpression searchOneLine([bool enable=true]){
    return _applyModifier('m', !enable);
  }

  VerbalExpression stopAtFirst([bool enable=true]){
    return _applyModifier('g', !enable);
  }

  VerbalExpression oneOrMore(){
    return add('+');
  }

  VerbalExpression zeroOrMore(){
    return add('*');
  }

  VerbalExpression count(int count){
    return add('{$count}');
  }

  VerbalExpression countRange(int min, int max){
    return add('{$min,$max}');
  }

  VerbalExpression atLeast(int min){
    return add('{$min,}');
  }

  VerbalExpression multiple(String value, {int min, int max}){

    if (min == null && max == null)
      return then(value).oneOrMore();

    if (max == null)
      return then(value).count(min);

    if (min == null)
      return then(value).countRange(1, max);

    return then(value).countRange(min, max);
  }

  VerbalExpression beginCapture(){
    _suffixes = ')$_suffixes';
    return add('(');
  }

  VerbalExpression endCapture(){
    // Remove the last parentheses from the _suffixes and add to the regex itself
    _suffixes = _suffixes.substring(0, _suffixes.length - 1);
    return add(')');
  }

  VerbalExpression or(String value){
    _prefixes += '(';
    _suffixes = ')$_suffixes';
    return add(')|(').then(value);
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
    return toRegExp().hasMatch(value);
  }
}