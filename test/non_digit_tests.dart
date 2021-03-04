library verbal_expressions.non_digit_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class NonDigitTests {
  ///
  static void run() {
    group('NonDigit', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..nonDigit()
          ..endOfLine();

        expect('$verbalExpression', '^\\D\$',
            reason: 'Regex should be "^\\D\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..nonDigit()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('5'), isFalse, reason: 'digit');
        expect(matcher.hasMatch('a'), isTrue, reason: 'non digit');
      });
    });
  }
}

void main() {
  NonDigitTests.run();
}
