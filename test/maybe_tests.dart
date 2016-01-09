library verbal_expressions.maybe_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class MaybeTests {
  static run(){
    group('Maybe', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .then('a')
        .maybe('b');

        expect(verbalExpressions.toRegExp().pattern, '^(a)(b)?', reason: 'Regex should be "^(a)(b)?"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .then('a')
        .maybe('b');

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('acb'), isTrue, reason: 'Maybe has a "b" after an "a"');
        expect(matcher.hasMatch('abc'), isTrue, reason: 'Maybe has a "b" after an "a"');
        expect(matcher.hasMatch('cab'), isFalse, reason: 'Maybe has a "b" after an "a"');
      });
    });
  }
}

void main() {
  MaybeTests.run();
}