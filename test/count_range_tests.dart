library verbal_expressions.count_range_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CountRangeTests {
  static run(){
    group('CountRange', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .countRange(2,5)
        .endOfLine();

        expect(verbalExpressions.toString(), '^(?:a){2,5}\$', reason: 'Regex should be "^(?:a){2,5}\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .find('a')
        .countRange(2,5)
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('a'), isFalse);
        expect(matcher.hasMatch('aaaaa'), isTrue);
        expect(matcher.hasMatch('aa'), isTrue);
        expect(matcher.hasMatch('aaaaaa'), isFalse);
        expect(matcher.hasMatch(''), isFalse);
      });
    });
  }
}

void main() {
  CountRangeTests.run();
}