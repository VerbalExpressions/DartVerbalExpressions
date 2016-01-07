library verbal_expressions.test;

import 'start_of_line_tests.dart';
import 'end_of_line_tests.dart';
import 'maybe_tests.dart';
import 'then_tests.dart';
import 'sanitize_tests.dart';
import 'anything_tests.dart';

void main() {
  StartOfLineTests.run();
  EndOfLineTests.run();
  MaybeTests.run();
  ThenTests.run();
  SanitizeTests.run();
  AnythingTests.run();
}
