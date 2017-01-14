library verbal_expressions.count_range_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CountRangeTests {
   static void run() {
    group('CountRange', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..countRange(2, 5)
          ..endOfLine();

        expect(verbalExpression.toString(), '^a{2,5}\$',
            reason: 'Regex should be "^a{2,5}\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..countRange(2, 5)
          ..endOfLine();

        RegExp matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isFalse);
        expect(matcher.hasMatch('aaaaa'), isTrue);
        expect(matcher.hasMatch('aa'), isTrue);
        expect(matcher.hasMatch('aaaaaa'), isFalse);
        expect(matcher.hasMatch(''), isFalse);
      });
    });
  }
}

void main() {
  CountRangeTests.run();
}
