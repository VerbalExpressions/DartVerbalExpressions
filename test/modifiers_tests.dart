library verbal_expressions.modifiers_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ModifiersTests {
  static run() {
    group('Modifiers', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should throw exception if add incorrect modifier', () {
        expect(() => verbalExpression.addModifier('u'),
            throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpression.addModifier('unknown'),
            throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpression.addModifier('n'),
            throwsA(predicate((e) => e is ArgumentError)));
      });

      test('Should throw exception if remove incorrect modifier', () {
        expect(() => verbalExpression.removeModifier('u'),
            throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpression.removeModifier('unknown'),
            throwsA(predicate((e) => e is ArgumentError)));
        expect(() => verbalExpression.removeModifier('n'),
            throwsA(predicate((e) => e is ArgumentError)));
      });
    });

    group('Case modifier', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should not ignore case by default', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse, reason: 'Should ignore case');
      });

      test('Should ignore case when withAnyCase is enabled', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..withAnyCase()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isTrue, reason: 'Should ignore case');
      });

      test('Should not ignore case when withAnyCase is disabled', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..withAnyCase(false)
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse,
            reason: 'Should not ignore case');
      });

      test('Should ignore case when "i" modifier is added', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..addModifier('i')
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isTrue, reason: 'Should ignore case');
      });

      test('Should not ignore case when "i" modifier is removed', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..addModifier('i')
          ..removeModifier('i')
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse,
            reason: 'Should not ignore case');
      });
    });
    group('MultiLine modifier', () {
      VerbalExpression verbalExpression;
      String multiLineText = '''multi line text
               test here''';

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should be multiline search by default', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..then('text')
          ..anything()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue,
            reason: 'Should search in multiple lines');
      });

      test('Should do multiline search when searchOneLine is disabled', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..then('text')
          ..anything()
          ..searchOneLine(false)
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue,
            reason: 'Should search in multiple lines');
      });

      test('Should not do multiline search when searchOneLine is enabled', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..then('text')
          ..anything()
          ..searchOneLine(true)
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(multiLineText), isFalse,
            reason: 'Should search in multiple lines');
      });

      test('Should do multiline search when "i" modifier is added', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..then('text')
          ..anything()
          ..addModifier('m')
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(multiLineText), isTrue,
            reason: 'Should search in multiple lines');
      });

      test('Should not do multiline search when "i" modifier is removed', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..then('text')
          ..anything()
          ..addModifier('m')
          ..removeModifier('m')
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(multiLineText), isFalse,
            reason: 'Should search in multiple lines');
      });
    });

    group('Global modifier', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should be replace first', () {
        verbalExpression
          ..find('test')
          ..stopAtFirst(true);
        expect(verbalExpression.replace('test test test', 'done'),
            'done test test');
      });

      test('Should be replace all', () {
        verbalExpression
          ..find('test')
          ..stopAtFirst(false);
        expect(verbalExpression.replace('test test test', 'done'),
            'done done done');
      });

      test('Should be replace first', () {
        verbalExpression
          ..find('test')
          ..stopAtFirst(false)
          ..removeModifier('g');
        expect(verbalExpression.replace('test test test', 'done'),
            'done test test');
      });

      test('Should be replace all', () {
        verbalExpression
          ..find('test')
          ..addModifier('g');
        expect(verbalExpression.replace('test test test', 'done'),
            'done done done');
      });
    });
  }
}

void main() {
  ModifiersTests.run();
}
