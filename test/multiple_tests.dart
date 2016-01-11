library verbal_expressions.multiple_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class MultipleTests {
  static run(){
    group('Multiple', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should be same as then and one or more', () {
        var actual = verbalExpressions.multiple('foo').toString();
        var expected = new VerbalExpressions().then('foo').oneOrMore().toString();

        expect(actual, expected);
      });

      test('Should be same as then and count', () {
        var actual = verbalExpressions.multiple('foo', min: 3).toString();
        var expected = new VerbalExpressions().then('foo').count(3).toString();

        expect(actual, expected);
      });

      test('Should be same as then and count range from one', () {
        var actual = verbalExpressions.multiple('foo', max: 5).toString();
        var expected = new VerbalExpressions().then('foo').countRange(1, 5).toString();

        expect(actual, expected);
      });

      test('Should be same as then and count range', () {
        var actual = verbalExpressions.multiple('foo', min: 3, max: 10).toString();
        var expected = new VerbalExpressions().then('foo').countRange(3,10).toString();

        expect(actual, expected);
      });

    });
  }
}

void main() {
  MultipleTests.run();
}