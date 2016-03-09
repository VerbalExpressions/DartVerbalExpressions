library verbal_expressions.capture_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CaptureTests {
  static run() {
    group('Capture', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..beginCapture()
          ..find('com')
          ..or('org')
          ..endCapture();

        expect(verbalExpression.toString(), '((?:com)|(?:org))',
            reason: 'Regex should be "((?:com)|(?:org))"');
      });

      test('Should match', () {
        const String testString = 'aaabcd';

        verbalExpression
          ..find('a')
          ..beginCapture()
          ..find("a")
          ..count(2)
          ..endCapture()
          ..beginCapture()
          ..find("b")
          ..anything()
          ..endCapture();

        var matcher = verbalExpression.toRegExp();
        var match = matcher.firstMatch(testString);
        expect(match.groupCount, 2);
        expect(match.group(0), 'aaabcd');
        expect(match.group(1), 'aa');
        expect(match.group(2), 'bcd');
      });


      test('Should not capture groups which are not set explicitly', () {
        const String testString = 'aaabcd';

        verbalExpression
          ..find('a')
          ..find("a")
          ..count(2)
          ..find("b")
          ..anything();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch(testString).groupCount, 0);
      });
    });
  }
}

void main() {
  CaptureTests.run();
}
