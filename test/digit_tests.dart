library verbal_expressions.digit_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class DigitTests {
  static run(){
    group('Digit', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .digit()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\d\$', reason: 'Regex should be "^\\D\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .digit()
        .endOfLine();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('5'), isTrue, reason: 'digit');
        expect(matcher.hasMatch('a'), isFalse, reason: 'non digit');
      });
    });
  }
}

void main() {
  DigitTests.run();
}