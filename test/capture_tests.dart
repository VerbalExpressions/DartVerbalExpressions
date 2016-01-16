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
        verbalExpression.beginCapture().find('com').or('org').endCapture();

        expect(verbalExpression.toString(), '((com)|(org))',
            reason: 'Regex should be "(((com))|((org)))"');
      });

      test('Should match', () {
        const String testString = 'aaabcd';

        verbalExpression
            .find('a')
            .beginCapture()
            .find("a")
            .count(2)
            .endCapture()
            .beginCapture()
            .find("b")
            .anything()
            .endCapture();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.firstMatch(testString).group(0), 'aaabcd');
        expect(matcher.firstMatch(testString).group(1), 'aa');
        expect(matcher.firstMatch(testString).group(2), 'bcd');
      });
    });
  }
}

void main() {
  CaptureTests.run();
}
