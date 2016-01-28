library verbal_expressions.anything_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnythingTests {
  static run() {
    group('Anything', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..endOfLine();

        expect(verbalExpression.toString(), '^(.*)\$',
            reason: 'Regex should be "^(.*)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('what'), isTrue);
        expect(matcher.hasMatch(' '), isTrue);
        expect(matcher.hasMatch(''), isTrue);
      });

      test('Should be greedy', () {
        verbalExpression
          ..find('a')
          ..anything()
          ..then('a');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch('greedy can be dangerous at times, really').group(0), 'an be dangerous at times, rea');
      });

      test('Should be lazy', () {
        verbalExpression
          ..find('a')
          ..anything(true)
          ..then('a');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch('greedy can be dangerous at times, really').group(0), 'an be da');
      });
    });
  }
}

void main() {
  AnythingTests.run();
}
