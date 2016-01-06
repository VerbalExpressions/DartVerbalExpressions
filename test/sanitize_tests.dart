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
        expect(() => verbalExpressions.sanitize(''), throwsA(predicate((e) => e is ArgumentError)));
      });

      //TODO write correct test and implementation
      test('Should return escaped string', () {
        var value = "*+?";
        var result = '';
        var expected = "\*\+\?";

        result = verbalExpressions.sanitize(value);

      expect(expected, result);
      });
    });
  }
}

void main() {
  SanitizeTests.run();
}