library verbal_expressions.capture_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class CaptureTests {
  static run(){
    group('Capture', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .beginCapture()
        .find('com')
        .or('org')
        .endCapture();

        expect(verbalExpressions.toString(), '((com)|(org))', reason: 'Regex should be "(((com))|((org)))"');
      });

      test('Should match', () {

        const String testString = 'aaabcd';

        // Act
        verbalExpressions
        .find('a')
        .beginCapture().find("a").count(2).endCapture()
        .beginCapture().find("b").anything().endCapture();

        var matcher = verbalExpressions.toRegExp();
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