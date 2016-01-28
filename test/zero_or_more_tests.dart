library verbal_expressions.zero_or_more_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ZeroOrMoreTests {
  static run() {
    group('Zero or more', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..zeroOrMore()
          ..endOfLine();

        expect(verbalExpression.toString(), '^a*\$',
            reason: 'Regex should be "^a*\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..zeroOrMore()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isTrue);
        expect(matcher.hasMatch('aaaaaaaaaaaaa'), isTrue);
        expect(matcher.hasMatch('ab'), isFalse);
        expect(matcher.hasMatch(''), isTrue);
      });

      test('Should be greedy', () {
        verbalExpression
          ..find('a')
          ..add('.')
          ..zeroOrMore()
          ..then('a');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch('greedy can be dangerous at times').group(0), 'an be dangerous a');
      });

      test('Should be lazy', () {
        verbalExpression
          ..find('a')
          ..add('.')
          ..zeroOrMore(true)
          ..then('a');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch('greedy can be dangerous at times').group(0), 'an be da');
      });
    });
  }
}

void main() {
  ZeroOrMoreTests.run();
}
