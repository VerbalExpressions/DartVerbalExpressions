library verbal_expressions.multiple_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class MultipleTests {
  static run() {
    group('Multiple', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should be same as then and one or more', () {
        var actual = verbalExpression..multiple('foo');
        var expected = new VerbalExpression()
          ..then('foo')
          ..oneOrMore();

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count', () {
        var actual = verbalExpression..multiple('foo', min: 3);
        var expected = new VerbalExpression()
          ..then('foo')
          ..count(3);

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count range from one', () {
        var actual = verbalExpression..multiple('foo', max: 5);
        var expected = new VerbalExpression()
          ..then('foo')
          ..countRange(1, 5);

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count range', () {
        var actual = verbalExpression..multiple('foo', min: 3, max: 10);
        var expected = new VerbalExpression()
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
