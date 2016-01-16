library verbal_expressions.start_of_line_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class StartOfLineTests {
  static run() {
    group('Start of line', () {
      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should add "^" in the beginning when is enable', () {
        verbalExpression.startOfLine(true);
        expect(verbalExpression.toString(), '^',
            reason: 'missing start of line regex');
      });

      test('Should not add "^" in the beginning when is not enable', () {
        verbalExpression.startOfLine(false);
        expect(verbalExpression.toString(), '',
            reason: 'missing start of line regex');
      });

      test(
          'Should append in the beginning of the expression when placed in random order',
          () {
        verbalExpression.find('test').then('ing').startOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('testing1234'), isTrue,
            reason: 'Should match that the text starts with test');
      });

      test('Should match http in start when Then(http).Maybe(wwww)', () {
        verbalExpression.startOfLine().then('http').maybe('www');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('http'), isTrue,
            reason: 'Should match http in start');
      });

      test('Should not match www in start when Then(http).Maybe(wwww)', () {
        verbalExpression.startOfLine().then('http').maybe('www');

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('www'), isFalse,
            reason: 'Should not match www in start');
      });
    });
  }
}

void main() {
  StartOfLineTests.run();
}
