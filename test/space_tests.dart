library verbal_expressions.whitespace_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class SpaceTests {
  static run() {
    group('Space', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..space()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\s\$',
            reason: 'Regex should be "^\\s\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..space()
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch(' '), isTrue, reason: 'whitespace');
        expect(matcher.hasMatch('1'), isFalse, reason: 'non whitespace');
      });
    });
  }
}

void main() {
  SpaceTests.run();
}
