library verbal_expressions.something_but_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SomethingButTests {
  static run() {
    group('SomethingBut', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression.startOfLine().somethingBut('test').endOfLine();

        expect(verbalExpression.toString(), '^([^test]+)\$',
            reason: 'Regex should be "^([^test]+)\$"');
      });

      test('Should match', () {
        verbalExpression.startOfLine().somethingBut('w').endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('what'), isFalse, reason: 'starts with w');
        expect(matcher.hasMatch('that'), isTrue, reason: 'Not contain w');
        expect(matcher.hasMatch(''), isFalse,
            reason: 'empty string doesn\'t have something');
      });
    });
  }
}

void main() {
  SomethingButTests.run();
}
