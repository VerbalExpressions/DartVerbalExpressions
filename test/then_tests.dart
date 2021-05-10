library verbal_expressions.then_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ThenTests {
  static void run() {
    group('Then', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..then('a')
          ..then('new');

        expect(verbalExpression.toString(), '^anew',
            reason: 'Regex should be "^(?:a)(?:new)"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..then('a')
          ..then('b')
          ..then('new');

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('anewb'), isFalse,
            reason: 'Correct order should be "a", "b", "c"');
        expect(matcher.hasMatch('abnew'), isTrue,
            reason: 'Correct order should be "a", "b", "c"');
        expect(matcher.hasMatch('newab'), isFalse,
            reason: 'Correct order should be "a", "b", "c"');
      });
    });
  }
}

void main() {
  ThenTests.run();
}
