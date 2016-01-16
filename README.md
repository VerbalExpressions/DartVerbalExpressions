# verbal_expressions

A library for Dart developers that helps to construct difficult regular expressions
Dart package info is here: https://pub.dartlang.org/packages/verbal_expressions

## Quick start

```dart
  var regex = new VerbalExpression()
  .startOfLine()
  .then("http").maybe("s")
  .then("://")
  .maybe("www.").anythingBut(" ")
  .endOfLine();

  // Create an example URL
  String url = "https://www.google.com";

  // Use VerbalExpression's hasMatch() method to test if the entire string matches the regex
  regex.hasMatch(url); //True

  regex.toString();   // Outputs the regex used: ^http(s)?\\:\\/\\/(www\\.)?([^\\ ]*)\$

```

```dart
  var regex = new VerbalExpression()
  .startOfLine().then("abc").or("def");

  var testString = "defzzz";
  //Use VerbalExpression's hasMatch() method to test if parts if the string match the regex
  regex.hasMatch(testString);   // true
```

Feel free to use any predefined char groups: 
```dart
  var regex = new VerbalExpression()
  .wordChar().nonWordChar()
  .space().nonSpace()
  .digit().nonDigit();
```

Define captures:
```dart 
  RegExp regex = new VerbalExpression()
  .find("a")
  .beginCapture().find("b").anything().endCapture()
  .then("cd")
  .toRegExp();

  var match = regex.firstMatch(text);
  print(match.group(0)); // returns "abcd"
  print(match.group(1)); // returns "b"
``` 


## Examples

More examples are in [example file](https://github.com/VerbalExpressions/DartVerbalExpressions/blob/master/example/verbal_expressions_example.dart)

## Features and bugs

Please find feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/VerbalExpressions/DartVerbalExpressions/issues
