library verbal_expressions.sanitize_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SanitizeTests {
   static void run() {
    group('Sanitize', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should throw exception if null or empty', () {
        expect(() => verbalExpression.sanitize(null),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.sanitize(null),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.sanitize(''),
            throwsA(predicate((Error e) => e is ArgumentError)));
      });

      test('Should return escaped string', () {
        String value = ".\$^{[(|)*+?\\non ecaped1234";
        String expected = "\\.\\\$\\^\\{\\[\\(\\|\\)\\*\\+\\?\\\\non\\ ecaped1234";

        String result = verbalExpression.sanitize(value);
        expect(result, expected);
      });
    });
  }
}

void main() {
  SanitizeTests.run();
}
