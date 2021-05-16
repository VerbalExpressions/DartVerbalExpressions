///
///
///
library verbal_expressions.test;

import 'any_of_tests.dart';
import 'any_tests.dart';
import 'anything_but_tests.dart';
import 'anything_tests.dart';
import 'at_least_tests.dart';
import 'br_tests.dart';
import 'capture_tests.dart';
import 'count_range_tests.dart';
import 'count_tests.dart';
import 'digit_tests.dart';
import 'end_of_line_tests.dart';
import 'line_break_tests.dart';
import 'maybe_tests.dart';
import 'modifiers_tests.dart';
import 'multiple_tests.dart';
import 'non_digit_tests.dart';
import 'non_space_tests.dart';
import 'non_word_char_tests.dart';
import 'one_or_more_tests.dart';
import 'or_tests.dart';
import 'range_tests.dart';
import 'real_world_tests.dart';
import 'replace_tests.dart';
import 'sanitize_tests.dart';
import 'something_but_tests.dart';
import 'something_tests.dart';
import 'space_tests.dart';
import 'start_of_line_tests.dart';
import 'tab_tests.dart';
import 'then_tests.dart';
import 'word_char_tests.dart';
import 'word_tests.dart';
import 'zero_or_more_tests.dart';

void main() {
  StartOfLineTests.run();
  EndOfLineTests.run();
  MaybeTests.run();
  ThenTests.run();
  SanitizeTests.run();
  AnythingTests.run();
  AnythingButTests.run();
  SomethingTests.run();
  SomethingButTests.run();
  LineBreakTests.run();
  BrTests.run();
  TabTests.run();
  WordTests.run();
  SpaceTests.run();
  AnyOfTests.run();
  AnyTests.run();
  RangeTests.run();
  DigitTests.run();
  NonDigitTests.run();
  WordCharTests.run();
  NonWordCharTests.run();
  NonSpaceTests.run();
  ModifiersTests.run();
  OneOrMoreTests.run();
  ZeroOrMoreTests.run();
  CountTests.run();
  CountRangeTests.run();
  AtLeastTests.run();
  ReplaceTests.run();
  MultipleTests.run();
  OrTests.run();
  CaptureTests.run();
  RealWorldTests.run();
}
