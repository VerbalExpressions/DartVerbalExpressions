library verbal_expressions.modifiers_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class ModifiersTests {
  static void run() {
    group('Modifiers', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should throw exception if add incorrect modifier', () {
        expect(() => verbalExpression.addModifier('u'),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.addModifier('unknown'),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.addModifier('n'),
            throwsA(predicate((Error e) => e is ArgumentError)));
      });

      test('Should throw exception if remove incorrect modifier', () {
        expect(() => verbalExpression.removeModifier('u'),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.removeModifier('unknown'),
            throwsA(predicate((Error e) => e is ArgumentError)));
        expect(() => verbalExpression.removeModifier('n'),
            throwsA(predicate((Error e) => e is ArgumentError)));
      });
    });

    group('Case modifier', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      test('Should not ignore case by default', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse, reason: 'Should ignore case');
      });

      test('Should ignore case when withAnyCase is enabled', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..withAnyCase()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isTrue, reason: 'Should ignore case');
      });

      test('Should not ignore case when withAnyCase is disabled', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..withAnyCase(false)
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse,
            reason: 'Should not ignore case');
      });

      test('Should ignore case when "i" modifier is added', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..addModifier('i')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isTrue, reason: 'Should ignore case');
      });

      test('Should not ignore case when "i" modifier is removed', () {
        verbalExpression
          ..startOfLine()
          ..find('test')
          ..addModifier('i')
          ..removeModifier('i')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('TeSt'), isFalse,
            reason: 'Should not ignore case');
      });
    });
    group('MultiLine modifier', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

      const String multiLineText = '''multi line text
               test here''';

      test('Should be multiline search by default', () {
        verbalExpression
          ..startOfLine()
          ..anything()
          ..then('text')
          ..anything()
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
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

        final matcher = verbalExpression.toRegExp();
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

        final matcher = verbalExpression.toRegExp();
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

        final matcher = verbalExpression.toRegExp();
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

        final matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(multiLineText), isFalse,
            reason: 'Should search in multiple lines');
      });
    });

    group('Global modifier', () {
      var verbalExpression = VerbalExpression();
      setUp(() => verbalExpression = VerbalExpression());

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
