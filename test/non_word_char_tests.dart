library verbal_expressions.non_word_char_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonWordCharTests {
  static run() {
    group('NonWordChar', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression.startOfLine().nonWordChar().endOfLine();

        expect(verbalExpression.toString(), '^\\W\$',
            reason: 'Regex should be "^\\W\$"');
      });

      test('Should match', () {
        verbalExpression.startOfLine().nonWordChar().endOfLine();

        var matcher = verbalExpression.toRegExp();
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
