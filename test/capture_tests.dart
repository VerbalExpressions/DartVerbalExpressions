library verbal_expressions.capture_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CaptureTests {
   static void run() {
    group('Capture', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..beginCapture()
          ..find('com')
          ..or('org')
          ..endCapture();

        expect(verbalExpression.toString(), '((?:com)|(?:org))', reason: 'Regex should be "((?:com)|(?:org))"');
      });

      test('Should throw exception when call endCapture() before call beginCapture()', () {
        expect(() => verbalExpression.endCapture(), throwsA(predicate((Error e) => e is StateError)));
      });

      test('Should match', () {
        const String testString = 'aaabbbcd_test';

        verbalExpression
          ..find('a')
          ..beginCapture()
          ..find("a")
          ..count(2)
          ..endCapture()
          ..beginCapture()
          ..find("b")
          ..anything()
          ..beginCapture()
          ..find('_')
          ..endCapture()
          ..anything()
          ..endCapture();

        RegExp matcher = verbalExpression.toRegExp();
        Match match = matcher.firstMatch(testString);
        expect(match.groupCount, 3);
        expect(match.group(0), testString);
        expect(match.group(1), 'aa');
        expect(match.group(2), 'bbbcd_test');
        expect(match.group(3), '_');
      });

      test('Should not capture groups which are not set explicitly', () {
        const String testString = 'aaabcd';

        verbalExpression
          ..find('a')
          ..find("a")
          ..count(2)
          ..find("b")
          ..anything();

        RegExp matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch(testString).groupCount, 0);
      });

      test('Should end capturing of unterminated groups', () {
        const String testString = 'aaabcd';

        verbalExpression
          ..find('a')
          ..beginCapture()
          ..find("a")
          ..count(2)
          ..beginCapture()
          ..find("b")
          ..anything();

        RegExp matcher = verbalExpression.toRegExp();
        Match match = matcher.firstMatch(testString);
        expect(match.groupCount, 2);
        expect(match.group(0), 'aaabcd');
        expect(match.group(1), 'aabcd');
        expect(match.group(2), 'bcd');
      });
    });
  }
}

void main() {
  CaptureTests.run();
}
