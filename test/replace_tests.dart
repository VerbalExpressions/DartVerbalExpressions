library verbal_expressions.replace_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ReplaceTests {
   static void run() {
    group('Replace', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should throw exception if null or empty', () {
        expect(() => verbalExpression.replace(null, 'value'),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.replace('source', null),
            throwsA(predicate((Error e) => e is ArgumentError)));
      });

      test('Should replace first', () {
        verbalExpression
          ..find('test')
          ..maybe('abc')
          ..anythingBut(' ')
          ..withAnyCase()
          ..stopAtFirst();

        expect(verbalExpression.replace('This is test here test', 'passed'),
            'This is passed here test');
        expect(verbalExpression.replace('This is test_here test', 'passed'),
            'This is passed test');
        expect(verbalExpression.replace('Testabc me test', 'passed'),
            'passed me test');
      });

      test('Should replace all', () {
        verbalExpression
          ..find('test')
          ..maybe('abc')
          ..anythingBut(' ')
          ..withAnyCase();

        expect(verbalExpression.replace('This is test here test', 'passed'),
            'This is passed here passed');
        expect(verbalExpression.replace('This is test_here test', 'passed'),
            'This is passed passed');
        expect(verbalExpression.replace('Testabc me test', 'passed'),
            'passed me passed');
      });
    });
  }
}

void main() {
  ReplaceTests.run();
}
