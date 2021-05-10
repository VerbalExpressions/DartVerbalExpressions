library verbal_expressions.one_or_more_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class OneOrMoreTests {
  static void run() {
    group('One or more', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

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

        final matcher = verbalExpression.toRegExp();
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
