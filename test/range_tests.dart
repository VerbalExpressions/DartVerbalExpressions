library verbal_expressions.range_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class RangeTests {
  static run(){
    group('Range', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should throw exception if range arguments are null or empty', () {
        expect(() => new Range(null, 'to'), throwsA(predicate((e) => e is ArgumentError)), reason: 'From should not null');
        expect(() => new Range('', 'to'), throwsA(predicate((e) => e is ArgumentError)), reason: 'From should not be empty');
        expect(() => new Range('from', null), throwsA(predicate((e) => e is ArgumentError)), reason: 'To should not be empty');
        expect(() => new Range('from', ''), throwsA(predicate((e) => e is ArgumentError)), reason: 'To should not be empty');
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .range([new Range('a', 'b'), new Range('0', '9')])
        .endOfLine();

        expect(verbalExpressions.toRegExp().pattern, '^[a-b0-9]\$', reason: 'Regex should be "^[a-b0-9]\$"');
      });

      test('Should match with multiple ranges', () {
        verbalExpressions
        .startOfLine()
        .range([new Range('a', 'z'), new Range('0', '5')])
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('b'), isTrue, reason: 'Regex don\'t matches letter');
        expect(matcher.hasMatch('A'), isFalse, reason: 'Regex matches capital leters, but should match only lower case');
      });
    });
  }
}

void main() {
  RangeTests.run();
}