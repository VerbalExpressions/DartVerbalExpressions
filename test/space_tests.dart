library verbal_expressions.whitespace_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SpaceTests {
  static run(){
    group('Space', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .space()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\s\$', reason: 'Regex should be "^\\s\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .space()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(' '), isTrue, reason: 'whitespace');
        expect(matcher.hasMatch('1'), isFalse, reason: 'non whitespace');
      });
    });
  }
}

void main() {
  SpaceTests.run();
}