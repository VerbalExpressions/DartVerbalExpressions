library verbal_expressions.real_world_tests;

import 'package:test/test.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

class RealWorldTests {
  static void run() {
    group('Real World', () {
      late VerbalExpression verbalExpression;
      setUp(() => verbalExpression = VerbalExpression());

      test('test url', () {
        verbalExpression
          ..startOfLine()
          ..then('http')
          ..maybe('s')
          ..then('://')
          ..maybe('www.')
          ..anythingBut(' ')
          ..endOfLine();

        const testUrl = 'https://www.google.com';

        expect(verbalExpression.hasMatch(testUrl), isTrue,
            reason: 'Matches Google\'s url');
        expect(verbalExpression.toString(),
            '^http(?:s)?\\:\\/\\/(?:www\\.)?(?:[^\\ ]*)\$',
            reason: 'Regex doesn\'t match same regex as in example');
      });

      test('test telephone number', () {
        verbalExpression
          ..startOfLine()
          ..then('+')
          ..beginCapture()
          ..range([Range('0', '9')])
          ..count(3)
          ..maybe('-')
          ..maybe(' ')
          ..endCapture()
          ..count(3)
          ..endOfLine();

        const phoneWithSpace = '+097 234 243';
        const phoneWithoutSpace = '+097234243';
        const phoneWithDash = '+097-234-243';

        expect(verbalExpression.hasMatch(phoneWithSpace), isTrue);
        expect(verbalExpression.hasMatch(phoneWithoutSpace), isTrue);
        expect(verbalExpression.hasMatch(phoneWithDash), isTrue);
      });

      test('complex pattern with multiply captures', () {
        const logLine =
            '3\t4\t1\thttp://localhost:20001\t1\t63528800\t0\t63528800\t1000000000\t0\t63528800\tSTR1';

        verbalExpression
          ..beginCapture()
          ..digit()
          ..oneOrMore()
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..digit()
          ..oneOrMore()
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..range([Range('0', '1')])
          ..count(1)
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..find('http://localhost:20')
          ..digit()
          ..count(3)
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..range([Range('0', '1')])
          ..count(1)
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..digit()
          ..oneOrMore()
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..range([Range('0', '1')])
          ..count(1)
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..digit()
          ..oneOrMore()
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..digit()
          ..oneOrMore()
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..range([Range('0', '1')])
          ..count(1)
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..digit()
          ..oneOrMore()
          ..endCapture()
          ..tab()
          ..beginCapture()
          ..find('STR')
          ..range([Range('0', '2')])
          ..count(1)
          ..endCapture();

        expect(verbalExpression.hasMatch(logLine), isTrue);
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
        const logLine =
            '3\t4\t1\thttp://localhost:20001\t1\t63528800\t0\t63528800\t1000000000\t0\t63528800\tSTR1';

        final digits = (VerbalExpression()
              ..beginCapture()
              ..digit()
              ..oneOrMore()
              ..endCapture()
              ..tab())
            .toString();
        final range = (VerbalExpression()
              ..beginCapture()
              ..range([Range('0', '1')])
              ..count(1)
              ..endCapture()
              ..tab())
            .toString();
        final host = (VerbalExpression()
              ..beginCapture()
              ..find('http://localhost:20')
              ..digit()
              ..count(3)
              ..endCapture()
              ..tab())
            .toString();
        final fake = (VerbalExpression()
              ..beginCapture()
              ..find('STR')
              ..range([Range('0', '2')])
              ..count(1)
              ..endCapture())
            .toString();

        verbalExpression
          ..add(digits)
          ..add(digits)
          ..add(range)
          ..add(host)
          ..add(range)
          ..add(digits)
          ..add(range)
          ..add(digits)
          ..add(digits)
          ..add(range)
          ..add(digits)
          ..add(fake);

        expect(verbalExpression.hasMatch(logLine), isTrue);

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
        verbalExpression.add('[A-Z0-1!-|]');
        expect(verbalExpression.toString(), '[A-Z0-1!-|]');
      });
    });
  }
}

void main() {
  RealWorldTests.run();
}
