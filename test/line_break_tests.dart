library verbal_expressions.line_break_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class LineBreakTests {
  static run(){
    group('LineBreak', () {

      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
        .startOfLine()
        .lineBreak()
        .endOfLine();

        expect(verbalExpression.toString(), '^(\\r\\n|\\r|\\n)\$', reason: 'Regex should be "^(\\r\\n|\\r|\\n)\$"');
      });

      test('Should match', () {
        verbalExpression
        .startOfLine()
        .then("abc")
        .lineBreak()
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
  LineBreakTests.run();
}