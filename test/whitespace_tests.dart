library verbal_expressions.whitespace_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class WhitespaceTests {
  static run(){
    group('Whitespace', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .whitespace()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\s\$', reason: 'Regex should be "^\\s\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .whitespace()
        .endOfLine();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch(' '), isTrue, reason: 'whitespace');
        expect(matcher.hasMatch('1'), isFalse, reason: 'non whitespace');
      });
    });
  }
}

void main() {
  WhitespaceTests.run();
}