library verbal_expressions.something_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SomethingTests {
  static void run() {
    group('Something', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..something()
          ..endOfLine();

        expect(verbalExpression.toString(), '^(?:.+)\$',
            reason: 'Regex should be "^(?:.+)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..something()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('what'), isTrue, reason: 'what');
        expect(matcher.hasMatch(' '), isTrue, reason: 'Space');
        expect(matcher.hasMatch(''), isFalse,
            reason: 'empty string doesn\'t have something');
      });
    });
  }
}

void main() {
  SomethingTests.run();
}
