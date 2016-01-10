library verbal_expressions.something_but_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SomethingButTests {
  static run(){
    group('SomethingBut', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .somethingBut('test')
        .endOfLine();

        expect(verbalExpressions.toString(), '^([^test]+)\$', reason: 'Regex should be "^([^test]+)\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .somethingBut('w')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('what'), isFalse, reason: 'starts with w');
        expect(matcher.hasMatch('that'), isTrue, reason: 'Not contain w');
        expect(matcher.hasMatch(''), isFalse, reason: 'empty string doesn\'t have something');
      });
    });
  }
}

void main() {
  SomethingButTests.run();
}