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
        expect(() => verbalExpressions.addModifier('n'), throwsA(predicate((e) => e is ArgumentError)));
      });

      test('Should throw exception if remove incorrect modifier', () {
        expect(() => verbalExpressions.removeModifier('u'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.removeModifier('unknown'), throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpressions.removeModifier('n'), throwsA(predicate((e) => e is ArgumentError)));
      });

    });

    group('Case modifier', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should not ignore case by default', () {
        verbalExpressions
        .startOfLine()
        .find('test')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse, reason: 'Should ignore case');
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

      test('Should be multiline search by default', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue, reason: 'Should search in multiple lines');
      });

      test('Should do multiline search when searchOneLine is disabled', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .searchOneLine(false)
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue, reason: 'Should search in multiple lines');
      });

      test('Should not do multiline search when searchOneLine is enabled', () {
        verbalExpressions
        .startOfLine()
        .anything()
        .then('text')
        .anything()
        .searchOneLine(true)
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

    group('Global modifier', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should be replace first', () {
        verbalExpressions.find('test').stopAtFirst(true);
        expect(verbalExpressions.replace('test test test', 'done'), 'done test test');
      });

      test('Should be replace all', () {
        verbalExpressions.find('test').stopAtFirst(false);
        expect(verbalExpressions.replace('test test test', 'done'), 'done done done');
      });

      test('Should be replace first', () {
        verbalExpressions.find('test').stopAtFirst(false).removeModifier('g');
        expect(verbalExpressions.replace('test test test', 'done'), 'done test test');
      });

      test('Should be replace all', () {
        verbalExpressions.find('test').addModifier('g');
        expect(verbalExpressions.replace('test test test', 'done'), 'done done done');
      });


    });
  }
}

void main() {
  ModifiersTests.run();
}