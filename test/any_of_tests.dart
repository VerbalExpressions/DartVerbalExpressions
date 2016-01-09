library verbal_expressions.any_of_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnyOfTests {
  static run(){
    group('AnyOf', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .anyOf('xyz')
        .endOfLine();

        expect(verbalExpressions.toRegExp().pattern, '^[xyz]\$', reason: 'Regex should be "^[xyz]\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .anyOf('xyz')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('ay'), isTrue, reason: 'Has an x, y, or z after a');
        expect(matcher.hasMatch('abc'), isFalse, reason: 'Doesn\'t have an x, y, or z after a');
      });
    });
  }
}

void main() {
  AnyOfTests.run();
}