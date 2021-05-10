library verbal_expressions.anything_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnythingTests {
  static void run() {
    group('Anything', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..endOfLine();

        expect(verbalExpression.toString(), '^(?:.*)\$',
            reason: 'Regex should be "^(?:.*)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('what'), isTrue);
        expect(matcher.hasMatch(' '), isTrue);
        expect(matcher.hasMatch(''), isTrue);
      });

      test('Should be greedy', () {
        verbalExpression
          ..find('a')
          ..anything()
          ..then('a');

        final matcher = verbalExpression.toRegExp();
        expect(
            matcher
                .firstMatch('greedy can be dangerous at times, really')!
                .group(0),
            'an be dangerous at times, rea');
      });

      test('Should be lazy', () {
        verbalExpression
          ..find('a')
          ..anything(true)
          ..then('a');

        final matcher = verbalExpression.toRegExp();
        expect(
            matcher
                .firstMatch('greedy can be dangerous at times, really')!
                .group(0),
            'an be da');
      });
    });
  }
}

void main() {
  AnythingTests.run();
}
