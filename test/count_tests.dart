library verbal_expressions.count_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CountTests {
  static void run() {
    group('Count', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..count(3)
          ..endOfLine();

        expect(verbalExpression.toString(), '^a{3}\$',
            reason: 'Regex should be "^a{3}\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..count(3)
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isFalse);
        expect(matcher.hasMatch('aaaa'), isFalse);
        expect(matcher.hasMatch('aaa'), isTrue);
        expect(matcher.hasMatch(''), isFalse);
      });
    });
  }
}

void main() {
  CountTests.run();
}
