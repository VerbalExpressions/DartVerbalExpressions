library verbal_expressions.something_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SomethingTests {
  static run(){
    group('Something', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .something()
        .endOfLine();

        expect(verbalExpressions.toString(), '^(.+)\$', reason: 'Regex should be "^(.+)\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .something()
        .endOfLine();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('what'), isTrue, reason: 'what');
        expect(matcher.hasMatch(' '), isTrue, reason: 'Space');
        expect(matcher.hasMatch(''), isFalse, reason: 'empty string doesn\'t have something');
      });
    });
  }
}

void main() {
  SomethingTests.run();
}