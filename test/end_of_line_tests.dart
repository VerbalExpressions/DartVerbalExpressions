library verbal_expressions.end_of_line_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class EndOfLineTests {
  static run(){
    group('End of line', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should match .com in the end when add .comm in the end', () {
        verbalExpressions
        .add('.com')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('www.google.com'), isTrue, reason: 'Should match ".com" in end');
      });

      test('Should not match "/" in the end when add .comm in the end', () {
        verbalExpressions
        .add('.com')
        .endOfLine();

        var matcher = verbalExpressions.toRegExp();
        expect(matcher.hasMatch('www.google.com/'), isFalse, reason: 'Should not match "/" in end');
      });
    });
  }
}

void main() {
  EndOfLineTests.run();
}