library verbal_expressions.anything_but_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnythingButTests {
  static run() {
    group('AnythingBut', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..anythingBut('test')
          ..endOfLine();

        expect(verbalExpression.toString(), '^([^test]*)\$',
            reason: 'Regex should be "^([^test]*)\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..anythingBut('w')
          ..endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('what'), isFalse, reason: 'starts with w');
        expect(matcher.hasMatch('that'), isTrue, reason: 'Not contain w');
        expect(matcher.hasMatch(' '), isTrue, reason: 'Not contain w');
      });
    });
  }
}

void main() {
  AnythingButTests.run();
}
