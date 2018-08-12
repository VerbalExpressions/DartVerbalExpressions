library verbal_expressions.whitespace_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SpaceTests {
   static void run() {
    group('Space', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..space()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\s\$',
            reason: 'Regex should be "^\\s\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..space()
          ..endOfLine();

        RegExp matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(' '), isTrue, reason: 'whitespace');
        expect(matcher.hasMatch('1'), isFalse, reason: 'non whitespace');
      });
    });
  }
}

void main() {
  SpaceTests.run();
}
