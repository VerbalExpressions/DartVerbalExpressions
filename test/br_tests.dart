library verbal_expressions.br_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class BrTests {
  static run(){
    group('br', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .br()
        .endOfLine();

        expect(verbalExpressions.toString(), '^(\\r\\n|\\r|\\n)\$', reason: 'Regex should be "^(\\r\\n|\\r|\\n)\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .then("abc")
        .br()
        .then("def")
        .endOfLine();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('abc\r\ndef'), isTrue, reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\ndef'), isTrue, reason: 'abc then line break then def');
        expect(matcher.hasMatch('abc\r\n def'), isFalse, reason: 'abc then line break then space then def');
      });
    });
  }
}

void main() {
  BrTests.run();
}