library verbal_expressions.multiple_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class MultipleTests {
   static void run() {
    group('Multiple', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should be same as then and one or more', () {
        VerbalExpression actual = verbalExpression..multiple('foo');
        VerbalExpression expected = new VerbalExpression()
          ..then('foo')
          ..oneOrMore();

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count', () {
        VerbalExpression actual = verbalExpression..multiple('foo', min: 3);
        VerbalExpression expected = new VerbalExpression()
          ..then('foo')
          ..count(3);

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count range from one', () {
        VerbalExpression actual = verbalExpression..multiple('foo', max: 5);
        VerbalExpression expected = new VerbalExpression()
          ..then('foo')
          ..countRange(1, 5);

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count range', () {
        VerbalExpression actual = verbalExpression..multiple('foo', min: 3, max: 10);
        VerbalExpression expected = new VerbalExpression()
          ..then('foo')
          ..countRange(3, 10);

        expect(actual.toString(), expected.toString());
      });
    });
  }
}

void main() {
  MultipleTests.run();
}
