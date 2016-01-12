library verbal_expressions.anything_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class AnythingTests {
  static run(){
    group('Anything', () {

      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
        .startOfLine()
        .anything()
        .endOfLine();

        expect(verbalExpression.toString(), '^(.*)\$', reason: 'Regex should be "^(.*)\$"');
      });

      test('Should match', () {
        verbalExpression
        .startOfLine()
        .anything()
        .endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('what'), isTrue);
        expect(matcher.hasMatch(' '), isTrue);
        expect(matcher.hasMatch(''), isTrue);
      });
    });
  }
}

void main() {
  AnythingTests.run();
}