library verbal_expressions.non_space_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonSpaceTests {
  static run(){
    group('NonSpace', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .nonSpace()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\S\$', reason: 'Regex should be "^\\S\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .nonSpace()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(' '), isFalse, reason: 'whitespace');
        expect(matcher.hasMatch('1'), isTrue, reason: 'non whitespace');
      });
    });
  }
}

void main() {
  NonSpaceTests.run();
}