library verbal_expressions.range_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class RangeTests {
  static run() {
    group('Range', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should throw exception if range arguments are null or empty', () {
        expect(() => new Range(null, 'to'),
            throwsA(predicate((e) => e is ArgumentError)),
            reason: 'From should not null');
        expect(() => new Range('', 'to'),
            throwsA(predicate((e) => e is ArgumentError)),
            reason: 'From should not be empty');
        expect(() => new Range('from', null),
            throwsA(predicate((e) => e is ArgumentError)),
            reason: 'To should not be empty');
        expect(() => new Range('from', ''),
            throwsA(predicate((e) => e is ArgumentError)),
            reason: 'To should not be empty');
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..range([new Range('a', 'b'), new Range('0', '9')])
          ..endOfLine();

        expect(verbalExpression.toString(), '^[a-b0-9]\$',
            reason: 'Regex should be "^[a-b0-9]\$"');
      });

      test('Should match with multiple ranges', () {
        verbalExpression
          ..startOfLine()
          ..range([new Range('a', 'z'), new Range('0', '5')])
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('b'), isTrue,
            reason: 'Regex don\'t matches letter');
        expect(matcher.hasMatch('A'), isFalse,
            reason:
                'Regex matches capital leters, but should match only lower case');
      });
    });
  }
}

void main() {
  RangeTests.run();
}
