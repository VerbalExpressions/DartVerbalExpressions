library verbal_expressions_example.example;

import 'package:verbal_expressions/verbal_expressions.dart';

void main() {
  const phoneWithSpace = '+097 234 243';
  matchTelephoneNumber(phoneWithSpace); //true
  // ...

  const phoneWithoutSpace = '+097234243';
  matchTelephoneNumber(phoneWithoutSpace); // true
  // ...

  const phoneWithDash = '+097-234-243';
  matchTelephoneNumber(phoneWithDash); // true
  // ...

  var domain = getDomain('https://www.google.com');
  print(domain); // .com

  domain = getDomain('http://ru.wikipedia.org/wiki/Dart');
  print(domain); // .org

  final expression = VerbalExpression()
    ..find('dog')
    ..stopAtFirst()
    ..withAnyCase();

  final testString = expression.replace(
      'Replace first DoG in the sentence but do not touch second dog', 'cat');

  // Replace first cat in the sentence but do not touch second dog
  print(testString);
}

///
String getDomain(String url) {
  final expression = VerbalExpression()
    ..startOfLine()
    ..then('http')
    ..maybe('s')
    ..then('://')
    ..maybe('www.')
    ..anythingBut(' ')
    ..beginCapture()
    ..then('.')
    ..anythingBut('/')
    ..endCapture()
    ..anything()
    ..endOfLine();

  return expression.toRegExp().firstMatch(url)!.group(1)!;
}

///
bool matchTelephoneNumber(String number) {
  final regex = VerbalExpression()
    ..startOfLine()
    ..then('+')
    ..beginCapture()
    ..range([Range('0', '9')])
    ..count(3)
    ..maybe('-')
    ..maybe(' ')
    ..endCapture()
    ..count(3)
    ..endOfLine();

  return regex.hasMatch(number);
}

///
bool matchUrl(String url) {
  final regex = VerbalExpression()
    ..startOfLine()
    ..then('http')
    ..maybe('s')
    ..then('://')
    ..maybe('www.')
    ..anythingBut(' ')
    ..endOfLine();

  return regex.hasMatch(url);
}
