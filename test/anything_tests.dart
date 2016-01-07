library verbal_expressions.anything_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class AnythingTests {
  static run(){
    group('Anything', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .anything();

        expect(verbalExpressions.toString(), '^(.*)', reason: 'Regex should be "^(.*)"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .anything();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('what'), isTrue);
        expect(matcher.hasMatch(' '), isTrue);
        expect(matcher.hasMatch(''), isTrue);
      });
    });
  }
}

void main() {
  AnythingTests.run();
}