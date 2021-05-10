library verbal_expressions.sanitize_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SanitizeTests {
  static void run() {
    group('Sanitize', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should throw exception if null or empty', () {
        expect(() => verbalExpression.sanitize(''),
            throwsA(predicate((Error e) => e is ArgumentError)));
      });

      test('Should return escaped string', () {
        const value = '.\$^{[(|)*+?\\non ecaped1234';
        const expected =
            '\\.\\\$\\^\\{\\[\\(\\|\\)\\*\\+\\?\\\\non\\ ecaped1234';

        final result = verbalExpression.sanitize(value);
        expect(result, expected);
      });
    });
  }
}

void main() {
  SanitizeTests.run();
}
