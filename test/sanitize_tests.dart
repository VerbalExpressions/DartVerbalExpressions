library verbal_expressions.sanitize_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SanitizeTests {
  static run() {
    group('Sanitize', () {
      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should throw exception if null or empty', () {
        expect(() => verbalExpressions.sanitize(null), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.sanitize(null), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.sanitize(''), throwsA(predicate((e) => e is ArgumentError)));
      });

      test('Should return escaped string', () {
        var value = ". \$ ^ { [ ( | ) * + ? \\";
        var expected = "\\. \\\$ \\^ \\{ \\[ \\( \\| \\) \\* \\+ \\? \\\\";

        var result = verbalExpressions.sanitize(value);
        expect(result, expected);
      });
    });
  }
}

void main() {
  SanitizeTests.run();
}