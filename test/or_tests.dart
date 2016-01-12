library verbal_expressions.or_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class OrTests {
  static run(){
    group('Or', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .then("abc")
        .or("def")
        .endOfLine();

        expect(verbalExpressions.toString(), '^(abc)|(def)\$', reason: 'Regex should be "^(abc)|(def)\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .then("abc")
        .or("def");

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('defzzz'), isTrue, reason: 'Starts with abc or def');
        expect(matcher.hasMatch('xyzabc'), isFalse, reason: 'Doesn\'t start with abc or def');
      });
    });
  }
}

void main() {
  OrTests.run();
}