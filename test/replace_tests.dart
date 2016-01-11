library verbal_expressions.replace_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ReplaceTests {
  static run() {
    group('Replace', () {
      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should throw exception if null or empty', () {
        expect(() => verbalExpressions.replace(null, 'value'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.replace('source', null), throwsA(predicate((e) => e is ArgumentError)));
      });

      test('Should replace first', () {

        verbalExpressions.find('test').maybe('abc').anythingBut(' ').withAnyCase();

        expect(verbalExpressions.replace('This is test here test', 'passed'), 'This is passed here test');
        expect(verbalExpressions.replace('This is test_here test', 'passed'), 'This is passed test');
        expect(verbalExpressions.replace('Testabc me test', 'passed'), 'passed me test');
      });

      test('Should replace all', () {

        verbalExpressions.find('test').maybe('abc').anythingBut(' ').withAnyCase().stopAtFirst(false);

        expect(verbalExpressions.replace('This is test here test', 'passed'), 'This is passed here passed');
        expect(verbalExpressions.replace('This is test_here test', 'passed'), 'This is passed passed');
        expect(verbalExpressions.replace('Testabc me test', 'passed'), 'passed me passed');
      });
    });
  }
}

void main() {
  ReplaceTests.run();
}