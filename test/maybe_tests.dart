library verbal_expressions.maybe_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class MaybeTests {
  static run() {
    group('Maybe', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should return correct regex', () {
        verbalExpression.startOfLine().then('a').maybe('b');

        expect(verbalExpression.toString(), '^a(b)?',
            reason: 'Regex should be "^a(b)?"');
      });

      test('Should match', () {
        verbalExpression.startOfLine().then('a').maybe('b');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('acb'), isTrue,
            reason: 'Maybe has a "b" after an "a"');
        expect(matcher.hasMatch('abc'), isTrue,
            reason: 'Maybe has a "b" after an "a"');
        expect(matcher.hasMatch('cab'), isFalse,
            reason: 'Maybe has a "b" after an "a"');
      });
    });
  }
}

void main() {
  MaybeTests.run();
}
