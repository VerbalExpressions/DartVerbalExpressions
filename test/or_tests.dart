library verbal_expressions.or_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class OrTests {
  static void run() {
    group('Or', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..then('abc')
          ..or('def')
          ..endOfLine();

        expect(verbalExpression.toString(), '^(?:abc)|(?:def)\$',
            reason: 'Regex should be "^(?:abc)|(?:def)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..then('abc')
          ..or('def');

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('defzzz'), isTrue,
            reason: 'Starts with abc or def');
        expect(matcher.hasMatch('xyzabc'), isFalse,
            reason: 'Doesn\'t start with abc or def');
      });
    });
  }
}

void main() {
  OrTests.run();
}
