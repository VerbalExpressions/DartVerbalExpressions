library verbal_expressions.any_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnyTests {
  static run(){
    group('Any', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .any('xyz')
        .endOfLine();

        expect(verbalExpressions.toRegExp().pattern, '^[xyz]\$', reason: 'Regex should be "^[xyz]\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .any('xyz')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('ay'), isTrue, reason: 'Has an x, y, or z after a');
        expect(matcher.hasMatch('abc'), isFalse, reason: 'Doesn\'t have an x, y, or z after a');
      });
    });
  }
}

void main() {
  AnyTests.run();
}