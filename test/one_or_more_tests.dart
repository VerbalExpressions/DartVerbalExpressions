library verbal_expressions.one_or_more_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class OneOrMoreTests {
  static run() {
    group('One or more', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..oneOrMore()
          ..endOfLine();

        expect(verbalExpression.toString(), '^a+\$',
            reason: 'Regex should be "^a+\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..oneOrMore()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isTrue);
        expect(matcher.hasMatch('aaaaaaaaaaaaa'), isTrue);
        expect(matcher.hasMatch('ab'), isFalse);
        expect(matcher.hasMatch(''), isFalse);
      });
    });
  }
}

void main() {
  OneOrMoreTests.run();
}
