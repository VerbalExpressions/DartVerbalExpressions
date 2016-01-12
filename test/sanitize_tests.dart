library verbal_expressions.sanitize_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class SanitizeTests {
  static run() {
    group('Sanitize', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should throw exception if null or empty', () {
        expect(() => verbalExpression.sanitize(null), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpression.sanitize(null), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpression.sanitize(''), throwsA(predicate((e) => e is ArgumentError)));
      });

      test('Should return escaped string', () {
        var value = ". \$ ^ { [ ( | ) * + ? \\";
        var expected = "\\. \\\$ \\^ \\{ \\[ \\( \\| \\) \\* \\+ \\? \\\\";

        var result = verbalExpression.sanitize(value);
        expect(result, expected);
      });
    });
  }
}

void main() {
  SanitizeTests.run();
}