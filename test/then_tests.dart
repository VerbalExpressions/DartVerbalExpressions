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

        expect(verbalExpressions.toString(), "^anew", reason: 'Regex should be "^(?:a)(?:new)"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .then("a")
        .then("b")
        .then("new");

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('anewb'), isFalse, reason: 'Correct order should be "a", "b", "c"');
        expect(matcher.hasMatch('abnew'), isTrue, reason: 'Correct order should be "a", "b", "c"');
        expect(matcher.hasMatch('newab'), isFalse, reason: 'Correct order should be "a", "b", "c"');
      });
    });
  }
}

void main() {
  ThenTests.run();
}