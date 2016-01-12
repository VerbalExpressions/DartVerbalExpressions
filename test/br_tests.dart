library verbal_expressions.br_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class BrTests {
  static run(){
    group('br', () {

      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
        .startOfLine()
        .br()
        .endOfLine();

        expect(verbalExpression.toString(), '^(\\r\\n|\\r|\\n)\$', reason: 'Regex should be "^(\\r\\n|\\r|\\n)\$"');
      });

      test('Should match', () {
        verbalExpression
        .startOfLine()
        .then("abc")
        .br()
        .then("def")
        .endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('abc\r\ndef'), isTrue, reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\ndef'), isTrue, reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\r\n def'), isFalse, reason: 'abc then line break then space then def');
      });
    });
  }
}

void main() {
  BrTests.run();
}