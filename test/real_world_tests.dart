library verbal_expressions.real_world_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class RealWorldTests {
  static run(){
    group('Real World', () {

      VerbalExpressions verbalExpressions;

      setUp(() {
        verbalExpressions = new VerbalExpressions();
      });

      test('test url', () {
        verbalExpressions
        .startOfLine()
        .then("http")
        .maybe("s")
        .then("://")
        .maybe("www.")
        .anythingBut(" ")
        .endOfLine();

        String testUrl = "https://www.google.com";

        expect(verbalExpressions.toRegExp().hasMatch(testUrl), isTrue, reason: 'Matches Google\'s url');
        expect(verbalExpressions.toString(), '^http(s)?://(www\\.)?([^ ]*)\$', reason: 'Regex doesn\'t match same regex as in example');
      });

      test('test telephone number', () {
        verbalExpressions
        .startOfLine()
        .then("+")
        .beginCapture().range([new Range('0','9')]).count(3).maybe("-").maybe(" ").endCapture()
        .count(3)
        .endOfLine();

        String phoneWithSpace = "+097 234 243";
        String phoneWithoutSpace = "+097234243";
        String phoneWithDash = "+097-234-243";

        expect(verbalExpressions.toRegExp().hasMatch(phoneWithSpace), isTrue);
        expect(verbalExpressions.toRegExp().hasMatch(phoneWithoutSpace), isTrue);
        expect(verbalExpressions.toRegExp().hasMatch(phoneWithDash), isTrue);
      });

      test('complex pattern with multiply captures', () {
        String logLine = "3\t4\t1\thttp://localhost:20001\t1\t63528800\t0\t63528800\t1000000000\t0\t63528800\tSTR1";

        verbalExpressions
        .beginCapture().digit().oneOrMore().endCapture().tab()
        .beginCapture().digit().oneOrMore().endCapture().tab()
        .beginCapture().range([new Range('0', '1')]).count(1).endCapture().tab()
        .beginCapture().find("http://localhost:20").digit().count(3).endCapture().tab()
        .beginCapture().range([new Range('0', '1')]).count(1).endCapture().tab()
        .beginCapture().digit().oneOrMore().endCapture().tab()
        .beginCapture().range([new Range('0', '1')]).count(1).endCapture().tab()
        .beginCapture().digit().oneOrMore().endCapture().tab()
        .beginCapture().digit().oneOrMore().endCapture().tab()
        .beginCapture().range([new Range('0', '1')]).count(1).endCapture().tab()
        .beginCapture().digit().oneOrMore().endCapture().tab()
        .beginCapture().find("STR").range([new Range('0', '2')]).count(1).endCapture();

        expect(verbalExpressions.toRegExp().hasMatch(logLine), isTrue);
        //(\\d+)\\t(\\d+)\\t([0-1]{1})\\t(http://localhost:20\\d{3})\\t([0-1]{1})
        // \\t(\\d+)\\t([0-1]{1})\\t(\\d+)\\t(\\d+)\\t([0-1]{1})\\t(\\d+)\\t(FAKE[1-2]{1})
        /*
        3    4    1    http://localhost:20001    1    28800    0    528800    1000000000    0    528800    STR1
        3    5    1    http://localhost:20002    1    28800    0    528800    1000020002    0    528800    STR2
        4    6    0    http://localhost:20002    1    48800    0    528800    1000000000    0    528800    STR1
        4    7    0    http://localhost:20003    1    48800    0    528800    1000020003    0    528800    STR2
        5    8    1    http://localhost:20003    1    68800    0    528800    1000000000    0    528800    STR1
        5    9    1    http://localhost:20004    1    28800    0    528800    1000020004    0    528800    STR2
         */
      });

      test('complex pattern with multiply captures 2', () {
        String logLine = "3\t4\t1\thttp://localhost:20001\t1\t63528800\t0\t63528800\t1000000000\t0\t63528800\tSTR1";

        var digits = new VerbalExpressions().beginCapture().digit().oneOrMore().endCapture().tab().toString();
        var range = new VerbalExpressions().beginCapture().range([new Range('0', '1')]).count(1).endCapture().tab().toString();
        var host = new VerbalExpressions().beginCapture().find("http://localhost:20").digit().count(3).endCapture().tab().toString();
        var fake = new VerbalExpressions().beginCapture().find("STR").range([new Range('0', '2')]).count(1).toString();

        verbalExpressions
        .add(digits).add(digits)
        .add(range).add(host).add(range).add(digits).add(range)
        .add(digits).add(digits)
        .add(range).add(digits).add(fake);

        expect(verbalExpressions.toRegExp().hasMatch(logLine), isTrue);


      //(\\d+)\\t(\\d+)\\t([0-1]{1})\\t(http://localhost:20\\d{3})\\t([0-1]{1})
        // \\t(\\d+)\\t([0-1]{1})\\t(\\d+)\\t(\\d+)\\t([0-1]{1})\\t(\\d+)\\t(FAKE[1-2]{1})
        /*
        3    4    1    http://localhost:20001    1    28800    0    528800    1000000000    0    528800    STR1
        3    5    1    http://localhost:20002    1    28800    0    528800    1000020002    0    528800    STR2
        4    6    0    http://localhost:20002    1    48800    0    528800    1000000000    0    528800    STR1
        4    7    0    http://localhost:20003    1    48800    0    528800    1000020003    0    528800    STR2
        5    8    1    http://localhost:20003    1    68800    0    528800    1000000000    0    528800    STR1
        5    9    1    http://localhost:20004    1    28800    0    528800    1000020004    0    528800    STR2
         */
      });

      test('unusual regex', () {
        expect(verbalExpressions.add("[A-Z0-1!-|]").toString(), '[A-Z0-1!-|]');
      });
    });
  }
}

void main() {
  RealWorldTests.run();
}