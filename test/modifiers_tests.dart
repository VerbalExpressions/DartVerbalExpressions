library verbal_expressions.modifiers_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ModifiersTests {
  static run(){
    group('Modifiers', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
      verbalExpressions = new VerbalExpressions();
      });

      test('Should throw exception if add incorrect modifier', () {
        expect(() => verbalExpressions.addModifier('u'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.addModifier('unknown'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.addModifier('g'), throwsA(predicate((e) => e is ArgumentError)));
      });

      test('Should throw exception if remove incorrect modifier', () {
        expect(() => verbalExpressions.removeModifier('u'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.removeModifier('unknown'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.removeModifier('g'), throwsA(predicate((e) => e is ArgumentError)));
      });

    });

    group('Case modifier', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should ignore case when withAnyCase is enabled', () {
        verbalExpressions
        .startOfLine()
        .find('test')
        .withAnyCase()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('TeSt'), isTrue, reason: 'Should ignore case');
      });

      test('Should not ignore case when withAnyCase is disabled', () {
        verbalExpressions
        .startOfLine()
        .find('test')
        .withAnyCase(false)
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse, reason: 'Should not ignore case');
      });

      test('Should ignore case when "i" modifier is added', () {
        verbalExpressions
        .startOfLine()
        .find('test')
        .addModifier('i')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('TeSt'), isTrue, reason: 'Should ignore case');
      });

      test('Should not ignore case when "i" modifier is removed', () {
        verbalExpressions
        .startOfLine()
        .find('test')
        .addModifier('i')
        .removeModifier('i')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse, reason: 'Should not ignore case');
      });
    });
    group('MultiLine modifier', () {

      VerbalExpressions verbalExpressions;
      String multiLineText = '''multi line text
               test here''';

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should do multiline search when multiLineSearch is enabled', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .multiLineSearch()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue, reason: 'Should search in multiple lines');
      });

      test('Should not do multiline search when multiLineSearch is disabled', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .multiLineSearch(false)
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(multiLineText), isFalse, reason: 'Should search in multiple lines');
      });

      test('Should do multiline search when "i" modifier is added', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .addModifier('m')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue, reason: 'Should search in multiple lines');
      });

      test('Should not do multiline search when "i" modifier is removed', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .addModifier('m')
        .removeModifier('m')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(multiLineText), isFalse, reason: 'Should search in multiple lines');
      });
    });
  }
}

void main() {
  ModifiersTests.run();
}