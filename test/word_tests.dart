library verbal_expressions.word_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class WordTests {
  static run(){
    group('Word', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .word()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\w+\$', reason: 'Regex should be "^\\t\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .word()
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('abc123'), isTrue, reason: 'word');
        expect(matcher.hasMatch('@#'), isFalse, reason: 'non-word');
      });
    });
  }
}

void main() {
  WordTests.run();
}