library verbal_expressions.multiple_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class MultipleTests {
  ///
  static void run() {
    group('Multiple', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should be same as then and one or more', () {
        final actual = verbalExpression..multiple('foo');
        final expected = VerbalExpression()
          ..then('foo')
          ..oneOrMore();

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count', () {
        final actual = verbalExpression..multiple('foo', min: 3);
        final expected = VerbalExpression()
          ..then('foo')
          ..count(3);

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count range from one', () {
        final actual = verbalExpression..multiple('foo', max: 5);
        final expected = VerbalExpression()
          ..then('foo')
          ..countRange(1, 5);

        expect(actual.toString(), expected.toString());
      });

      test('Should be same as then and count range', () {
        final actual = verbalExpression..multiple('foo', min: 3, max: 10);
        final expected = VerbalExpression()
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
