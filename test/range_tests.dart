library verbal_expressions.range_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class RangeTests {
  ///
  static void run() {
    group('Range', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should throw exception if range arguments are null or empty', () {
        expect(
          () => Range('', 'to'),
          throwsA(predicate((Error e) => e is ArgumentError)),
          reason: 'From should not be empty',
        );
        expect(
          () => Range('from', ''),
          throwsA(predicate((Error e) => e is ArgumentError)),
          reason: 'To should not be empty',
        );
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..range([Range('a', 'b'), Range('0', '9')])
          ..endOfLine();

        expect('$verbalExpression', '^[a-b0-9]\$',
            reason: 'Regex should be "^[a-b0-9]\$"');
      });

      test('Should match with multiple ranges', () {
        verbalExpression
          ..startOfLine()
          ..range([Range('a', 'z'), Range('0', '5')])
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('b'), isTrue,
            reason: 'Regex don\'t matches letter');
        expect(
          matcher.hasMatch('A'),
          isFalse,
          reason:
              'Regex matches capital leters, but should match only lower case',
        );
      });
    });
  }
}

void main() {
  RangeTests.run();
}
