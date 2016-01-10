library verbal_expressions.zero_or_more_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ZeroOrMoreTests {
  static run(){
    group('Zero or more', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .zeroOrMore()
        .endOfLine();

        expect(verbalExpressions.toString(), '^(a)*\$', reason: 'Regex should be "^(a)*\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .zeroOrMore()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('a'), isTrue);
        expect(matcher.hasMatch('aaaaaaaaaaaaa'), isTrue);
        expect(matcher.hasMatch('ab'), isFalse);
        expect(matcher.hasMatch(''), isTrue);
      });
    });
  }
}

void main() {
  ZeroOrMoreTests.run();
}