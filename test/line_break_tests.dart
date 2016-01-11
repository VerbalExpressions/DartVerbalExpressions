library verbal_expressions.line_break_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class LineBreakTests {
  static run(){
    group('LineBreak', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .lineBreak()
        .endOfLine();

        expect(verbalExpressions.toString(), '^(?:\\r\\n|\\r|\\n)\$', reason: 'Regex should be "^(?:\\r\\n|\\r|\\n)\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .then("abc")
        .lineBreak()
        .then("def")
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
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