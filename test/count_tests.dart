library verbal_expressions.count_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CountTests {
  static run(){
    group('Count', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .count(3)
        .endOfLine();

        expect(verbalExpressions.toString(), '^(?:a){3}\$', reason: 'Regex should be "^(?:a){3}\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .count(3)
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('a'), isFalse);
        expect(matcher.hasMatch('aaaa'), isFalse);
        expect(matcher.hasMatch('aaa'), isTrue);
        expect(matcher.hasMatch(''), isFalse);
      });
    });
  }
}

void main() {
  CountTests.run();
}