library verbal_expressions.anything_but_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class AnythingButTests {
  ///
  static void run() {
    group('AnythingBut', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..anythingBut('test')
          ..endOfLine();

        expect('$verbalExpression', '^(?:[^test]*)\$',
            reason: 'Regex should be "^(?:[^test]*)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..anythingBut('w')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();

        expect(matcher.hasMatch('what'), isFalse, reason: 'starts with w');
        expect(matcher.hasMatch('that'), isTrue, reason: 'Not contain w');
        expect(matcher.hasMatch(' '), isTrue, reason: 'Not contain w');
      });

      test('Should be greedy', () {
        verbalExpression
          ..find('a')
          ..anythingBut('i')
          ..then('a');

        final matcher = verbalExpression.toRegExp();

        expect(
          matcher
              .firstMatch('greedy can be dangerous at times, really')!
              .group(0),
          'an be dangerous a',
        );
      });

      test('Should be lazy', () {
        verbalExpression
          ..find('a')
          ..anythingBut('i', true)
          ..then('a');

        final matcher = verbalExpression.toRegExp();
        expect(
          matcher
              .firstMatch('greedy can be dangerous at times, really')!
              .group(0),
          'an be da',
        );
      });
    });
  }
}

void main() {
  AnythingButTests.run();
}
