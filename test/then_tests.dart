library verbal_expressions.then_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ThenTests {
  static run(){
    group('Then', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .then("a")
        .then("new");

        expect(verbalExpressions.toString(), "^(a)(new)", reason: 'Regex should be "^(a)(new)"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .then("a")
        .then("b")
        .then("c");

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('acb'), isFalse, reason: 'Correct order should be "a", "b", "c"');
        expect(matcher.hasMatch('abc'), isTrue, reason: 'Correct order should be "a", "b", "c"');
        expect(matcher.hasMatch('cab'), isFalse, reason: 'Correct order should be "a", "b", "c"');
      });
    });
  }
}

void main() {
  ThenTests.run();
}