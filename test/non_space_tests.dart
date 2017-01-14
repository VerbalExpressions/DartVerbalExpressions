library verbal_expressions.non_space_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonSpaceTests {
   static void run() {
    group('NonSpace', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..nonSpace()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\S\$',
            reason: 'Regex should be "^\\S\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..nonSpace()
          ..endOfLine();

        RegExp matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(' '), isFalse, reason: 'whitespace');
        expect(matcher.hasMatch('1'), isTrue, reason: 'non whitespace');
      });
    });
  }
}

void main() {
  NonSpaceTests.run();
}
