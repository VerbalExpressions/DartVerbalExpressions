library verbal_expressions.non_digit_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonDigitTests {
   static void run() {
    group('NonDigit', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..nonDigit()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\D\$',
            reason: 'Regex should be "^\\D\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..nonDigit()
          ..endOfLine();

        RegExp matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('5'), isFalse, reason: 'digit');
        expect(matcher.hasMatch('a'), isTrue, reason: 'non digit');
      });
    });
  }
}

void main() {
  NonDigitTests.run();
}
