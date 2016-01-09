library verbal_expressions.non_digit_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonDigitTests {
  static run(){
    group('NonDigit', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .nonDigit()
        .endOfLine();

        expect(verbalExpressions.toRegExp().pattern, '^\\D\$', reason: 'Regex should be "^\\D\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .nonDigit()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('5'), isFalse, reason: 'digit');
        expect(matcher.hasMatch('a'), isTrue, reason: 'non digit');
      });
    });
  }
}

void main() {
  NonDigitTests.run();
}