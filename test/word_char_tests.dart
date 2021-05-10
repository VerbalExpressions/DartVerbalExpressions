library verbal_expressions.word_char_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class WordCharTests {
  static void run() {
    group('WordChar', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..wordChar()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\w\$',
            reason: 'Regex should be "^\\w\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..word()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isTrue, reason: 'word character');
        expect(matcher.hasMatch('5'), isTrue, reason: 'word character');
        expect(matcher.hasMatch('@'), isFalse, reason: 'non word character');
      });
    });
  }
}

void main() {
  WordCharTests.run();
}
