library verbal_expressions.br_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

///
class BrTests {
  ///
  static void run() {
    group('br', () {
      final verbalExpression = VerbalExpression();

      setUp(() {});

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..br()
          ..endOfLine();

        expect('$verbalExpression', '^(?:\\r\\n|\\r|\\n|\\r\\r)\$',
            reason: 'Regex should be "^(?:\\r\\n|\\r|\\n|\\r\\r)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..then('abc')
          ..br()
          ..then('def')
          ..endOfLine();

        final matcher = verbalExpression.toRegExp();
        expect(
          matcher.hasMatch('abc\r\ndef'),
          isTrue,
          reason: 'abc then line break then def',
        );
        expect(
          matcher.hasMatch('abc\ndef'),
          isTrue,
          reason: 'abc then line break then def',
        );
        expect(
          matcher.hasMatch('abc\r\rdef'),
          isTrue,
          reason: 'abc then line break then def',
        );
        expect(
          matcher.hasMatch('abc\r\n def'),
          isFalse,
          reason: 'abc then line break then space then def',
        );
      });
    });
  }
}

void main() {
  BrTests.run();
}
