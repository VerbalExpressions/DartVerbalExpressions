library verbal_expressions.at_least_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class AtLeastTests {
  ///
  static void run() {
    group('AtLeast', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..atLeast(3)
          ..endOfLine();

        expect('$verbalExpression', '^a{3,}\$',
            reason: 'Regex should be "^a{3,}\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..atLeast(3)
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('a'), isFalse);
        expect(matcher.hasMatch('aaa'), isTrue);
        expect(matcher.hasMatch('aaaaaaaaaa'), isTrue);
        expect(matcher.hasMatch(''), isFalse);
      });
    });
  }
}

void main() {
  AtLeastTests.run();
}
