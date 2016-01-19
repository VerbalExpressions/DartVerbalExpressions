library verbal_expressions.something_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SomethingTests {
  static run() {
    group('Something', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..something()
          ..endOfLine();

        expect(verbalExpression.toString(), '^(.+)\$',
            reason: 'Regex should be "^(.+)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..something()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
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
