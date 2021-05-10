library verbal_expressions.any_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnyTests {
  static void run() {
    group('Any', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..any('xyz')
          ..endOfLine();

        expect(verbalExpression.toString(), '^[xyz]\$',
            reason: 'Regex should be "^[xyz]\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..find('a')
          ..any('xyz')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('ay'), isTrue,
            reason: 'Has an x, y, or z after a');
        expect(matcher.hasMatch('abc'), isFalse,
            reason: 'Doesn\'t have an x, y, or z after a');
      });
    });
  }
}

void main() {
  AnyTests.run();
}
