library verbal_expressions.non_word_char_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonWordCharTests {
  static void run() {
    group('NonWordChar', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..nonWordChar()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\W\$',
            reason: 'Regex should be "^\\W\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..nonWordChar()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isFalse, reason: 'word character');
        expect(matcher.hasMatch('5'), isFalse, reason: 'word character');
        expect(matcher.hasMatch('@'), isTrue, reason: 'non word character');
      });
    });
  }
}

void main() {
  NonWordCharTests.run();
}
