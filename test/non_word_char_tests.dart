library verbal_expressions.non_word_char_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class NonWordCharTests {
  static run(){
    group('NonWordChar', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .nonWordChar()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\W\$', reason: 'Regex should be "^\\W\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .nonWordChar()
        .endOfLine();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('a'), isFalse, reason: 'word character');
        expect(matcher.hasMatch('5'), isFalse, reason: 'word character');
        expect(matcher.hasMatch('@'), isTrue, reason: 'non word character');
      });
    });
  }
}

void main() {
  NonWordCharTests.run();
}