library verbal_expressions.digit_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class DigitTests {
  ///
  static void run() {
    group('Digit', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..digit()
          ..endOfLine();

        expect('$verbalExpression', '^\\d\$',
            reason: 'Regex should be "^\\D\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..digit()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('5'), isTrue, reason: 'digit');
        expect(matcher.hasMatch('a'), isFalse, reason: 'non digit');
      });
    });
  }
}

void main() {
  DigitTests.run();
}
