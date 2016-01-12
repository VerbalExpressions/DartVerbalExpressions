library verbal_expressions.end_of_line_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expression.dart';

class EndOfLineTests {
  static run(){
    group('End of line', () {

      VerbalExpression verbalExpression;

      setUp(() {
        verbalExpression = new VerbalExpression();
      });

      test('Should match .com in the end when add .comm in the end', () {
        verbalExpression
        .find('.com')
        .endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('www.google.com'), isTrue, reason: 'Should match ".com" in end');
      });

      test('Should not match "/" in the end when add .comm in the end', () {
        verbalExpression
        .find('.com')
        .endOfLine();

        var matcher = verbalExpression.toRegExp();
        expect(matcher.hasMatch('www.google.com/'), isFalse, reason: 'Should not match "/" in end');
      });
    });
  }
}

void main() {
  EndOfLineTests.run();
}