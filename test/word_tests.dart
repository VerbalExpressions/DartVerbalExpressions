library verbal_expressions.word_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class WordTests {
  static void run() {
    group('Word', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..word()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\w+\$',
            reason: 'Regex should be "^\\t\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..word()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('abc123'), isTrue, reason: 'word');
        expect(matcher.hasMatch('@#'), isFalse, reason: 'non-word');
      });
    });
  }
}

void main() {
  WordTests.run();
}
