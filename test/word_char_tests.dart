library verbal_expressions.word_char_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class WordCharTests {
  static run(){
    group('WordChar', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .wordChar()
        .endOfLine();

        expect(verbalExpressions.toRegExp().pattern, '^\\w\$', reason: 'Regex should be "^\\w\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .word()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('a'), isTrue, reason: 'word character');
        expect(matcher.hasMatch('5'), isTrue, reason: 'word character');
        expect(matcher.hasMatch('@'), isFalse, reason: 'non word character');
      });
    });
  }
}

void main() {
  WordCharTests.run();
}