library verbal_expressions.tab_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class TabTests {
  static run(){
    group('tab', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('Should return correct regex', () {
        verbalExpressions
        .startOfLine()
        .tab()
        .endOfLine();

        expect(verbalExpressions.toString(), '^\\t\$', reason: 'Regex should be "^\\t\$"');
      });

      test('Should match', () {
        verbalExpressions
        .startOfLine()
        .tab()
        .then("abc")
        .endOfLine();

        var matcher = new RegExp(verbalExpressions.toString());
        expect(matcher.hasMatch('\tabc'), isTrue, reason: 'tab then abc');
        expect(matcher.hasMatch('abc'), isFalse, reason: 'no tab then abc');
      });
    });
  }
}

void main() {
  TabTests.run();
}