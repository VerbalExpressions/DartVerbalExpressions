library verbal_expressions.tab_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class TabTests {
   static void run() {
    group('tab', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression
          ..startOfLine()
          ..tab()
          ..endOfLine();

        expect(verbalExpression.toString(), '^\\t\$',
            reason: 'Regex should be "^\\t\$"');
      });

      test('Should match', () {
        verbalExpression
          ..startOfLine()
          ..tab()
          ..then("abc")
          ..endOfLine();

        RegExp matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('\tabc'), isTrue, reason: 'tab then abc');
        expect(matcher.hasMatch('abc'), isFalse, reason: 'no tab then abc');
      });
    });
  }
}

void main() {
  TabTests.run();
}
