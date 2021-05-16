library verbal_expressions.line_break_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class LineBreakTests {
  static void run() {
    group('LineBreak', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..lineBreak()
          ..endOfLine();

        expect(verbalExpression.toString(), '^(?:\\r\\n|\\r|\\n|\\r\\r)\$',
            reason: 'Regex should be "^(?:\\r\\n|\\r|\\n|\\r\\r)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..then('abc')
          ..lineBreak()
          ..then('def')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('abc\r\ndef'), isTrue,
            reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\ndef'), isTrue,
            reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\r\rdef'), isTrue,
            reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\r\n def'), isFalse,
            reason: 'abc then line break then space then def');
      });
    });
  }
}

void main() {
  LineBreakTests.run();
}
